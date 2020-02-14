// Copyright 2018, Intel Corp.

#include <chrono>
#include <gmock/gmock.h>
#include <google/protobuf/text_format.h>

#include "base/proto/proto.h"
#include "tile/codegen/codegen.pb.h"
#include "tile/codegen/driver.h"
#include "tile/codegen/tile.h"
#include "tile/lang/gen_stripe.h"
#include "tile/lang/runinfo.h"
#include "tile/stripe/stripe.h"
#include "tile/stripe/stripe.pb.h"
#include "tile/targets/cpu/jit.h"

namespace gp = google::protobuf;

using ::testing::ContainerEq;
using ::testing::Eq;

namespace vertexai {
namespace tile {
using namespace codegen;
namespace targets {
namespace cpu {
namespace test {

static vertexai::tile::codegen::proto::Stage GenerateStage() {
  auto cfg_tmpl = R"(
    passes: [
      {
        name: "localize_tmps",
        pass: {
          [type.vertex.ai/vertexai.tile.codegen.proto.LocalizePass] {
            reqs: ["program"],
            ref_reqs: ["tmp"]
          }
        }
      },
      {
        name: "prune_refs",
        pass: {
          [type.vertex.ai/vertexai.tile.codegen.proto.PruneRefinementsPass] {
            reqs: ["program"]
          }
        }
      },
      {
        name: "mlir_nop",
        pass: {
                [type.vertex.ai/vertexai.tile.codegen.proto.MLIR_NopPass] {
        }
        }
      },
      {
        name: "pad",
        pass: {
            [type.vertex.ai/vertexai.tile.codegen.proto.PadPass] {
            reqs: ["main"],
        }
        }
      },
      {
    name: "mlir_auto_stencil",
    pass: {
            [type.vertex.ai/vertexai.tile.codegen.proto.MLIR_AutoStencilPass] {
        reqs: ["agg_op_add", "comb_op_mul"],
        startup_cost: 32,
        only_even: [true, true, true],
        only_po2: [false, false, false],
        special_stencils: [
          {
              startup_cost: 32,
              idxs: [
                  { name: "m", size: 64, outs: [1], ins: [0, 1] },
                  { name: "n", size: 16, outs: [-1], ins: [-1, 0] },
                  { name: "k", size: 3, outs: [0], ins: [1, -1] }
              ]
          }
        ]
        }
        }
      },
      {
          name: "fuse_mac_eltwise",
          pass: {
              [type.vertex.ai/vertexai.tile.codegen.proto.FusionPass] {
              a_reqs: ["mac"],
              b_reqs: ["eltwise"],
              fused_set: ["mac"],
          }
          }
      },
      {
          name: "fuse_mac_inner_eltwise",
          pass: {
              [type.vertex.ai/vertexai.tile.codegen.proto.FusionPass] {
              parent_reqs: ["mac"],
              fused_set: ["eltwise"],
              exclude: ["mac_inner"],
              no_inner: true,
          }
          }
      },
      {
          name: "eltwise fuse",
          pass: {
              [type.vertex.ai/vertexai.tile.codegen.proto.FusionPass] {
              parent_reqs: ["main"],
              a_reqs: ["eltwise"],
              b_reqs: ["eltwise"],
              fused_set: ["eltwise"],
          }
          }
      },
      {
    name: "localize_main",
    pass: {
        [type.vertex.ai/vertexai.tile.codegen.proto.LocalizePass] {
    reqs: ["main"]
    }
    }
},
{
    name: "scalarize_main",
    pass: {
        [type.vertex.ai/vertexai.tile.codegen.proto.ScalarizePass] {
    reqs: ["main"]
    }
    }
},
{
    name: "prune_idxs",
    pass: {
        [type.vertex.ai/vertexai.tile.codegen.proto.PruneIndexesPass] {
    reqs: ["program"]
    }
    }
},
{
    name: "tile_contract",
    pass: {
        [type.vertex.ai/vertexai.tile.codegen.proto.AutotilePass] {
    reqs: ["contraction"],
    inner_set: ["contract_inner"],
    outer_set: ["contract_outer", "kernel", "cpu_thread"],
    acc_idxs: false,
    input_cost: 0.0,
    output_cost: 0.0,
    split_factor: -100.0,
    cache_width: 64,
    only_po2: true
    }
    }
},
{
    name: "dead_code_elimination",
    pass: {
        [type.vertex.ai/vertexai.tile.codegen.proto.DeadCodeEliminationPass] {
    reqs: ["all"]
    }
    }
},
{
    name: "locate_program",
    pass: {
        [type.vertex.ai/vertexai.tile.codegen.proto.LocateBlocksRefinementsRecursivelyPass] {
        reqs: ["program"],
        skip_tags: ["user"],
        loc: { devs: [{ name: "DRAM" }] }
        }
    ]
},{
    name: "prune_refs",
    pass: {
        [type.vertex.ai/vertexai.tile.codegen.proto.PruneRefinementsPass] {
    reqs: ["program"]
    }
    }
},
{
    name: "mlir_agginit",
    pass: {
            [type.vertex.ai/vertexai.tile.codegen.proto.MLIR_AggInitPass] {
        reqs: ["contraction"],
        parallel: true,
        cache_line: 64
            }
    }
    }
}
    ]
  )";
  return ParseProtoText<vertexai::tile::codegen::proto::Stage>(cfg_tmpl);
}

TEST(Jit, AddPlain) {
  size_t S = 1;
  size_t L = 3;
  size_t N = 8192;

  size_t ctxt_size = S * L * N;
  size_t ptxt_size = 1 * L * N;

  std::vector<uint64_t> cipher_buf(ctxt_size, 1);
  std::vector<uint64_t> plain_buf(ptxt_size, 1);
  std::vector<uint64_t> q_buf(ptxt_size, 1);
  std::vector<uint64_t> out_buf(ctxt_size, 0);

  lang::RunInfo runinfo;
  runinfo.program_name = "add_plain";
  runinfo.code = R"(function (C[D0,D1,D2], P, Q) -> (O) {
      Summ = C + P;
      Comp = as_int(Summ >= Q, 64);
      Comp_cast = as_uint(-Comp, 64);
      O = Summ - (Comp_cast * Q);
    }
)";
  runinfo.input_shapes.emplace("C", SimpleShape(DataType::UINT64, {S, L, N}));
  runinfo.input_shapes.emplace("P", SimpleShape(DataType::UINT64, {1, L, N}));
  runinfo.input_shapes.emplace("Q", SimpleShape(DataType::UINT64, {1, L, 1}));
  runinfo.output_shapes.emplace("O", SimpleShape(DataType::UINT64, {S, L, N}));

  auto program = GenerateStripe(runinfo);
  auto main = program->entry;

  LOG(INFO) << "Before>\n" << *main;

  auto stage = GenerateStage();
  auto dbg_dir = std::getenv("DBG_DIR");
  OptimizeOptions options;
  if (dbg_dir) {
    options.dump_passes = true;
    options.dbg_dir = dbg_dir;
    IVLOG(1, "Writing passes to: " << dbg_dir);
  }
  codegen::CompilerState state(program);
  codegen::Optimize(&state, stage.passes(), options);

  // Expected result should not contain X_T4
  // std::string actual_after = RemoveComments(to_string(*program->entry));
  LOG(INFO) << "After stripe optimization: " << *program->entry;

  std::map<std::string, void*> data = {
      {"C", cipher_buf.data()},
      {"P", plain_buf.data()},
      {"Q", q_buf.data()},
      {"O", out_buf.data()},
  };

  JitExecute(*main, data);
  JitExecute(*main, data);
  // JitExecute(*main, data);
  // JitExecute(*main, data);
  // JitExecute(*main, data);
  // JitExecute(*main, data);
  /* for (size_t i = 0; i < 10; ++i) {
    JitExecute(*main, data);
  } */
  LOG(INFO) << "cipher: " << cipher_buf;
  LOG(INFO) << "plain: " << plain_buf;
  LOG(INFO) << "out: " << out_buf;
  // EXPECT_THAT(bufC, ContainerEq(expected));
}

}  // namespace test
}  // namespace cpu
}  // namespace targets
}  // namespace tile
}  // namespace vertexai
