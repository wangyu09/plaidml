// Copyright 2020 Intel Corporation

#include "pmlc/dialect/pxa/transforms/fuse.h"

#include <map>
#include <string>

#include "pmlc/dialect/pxa/analysis/read_write.h"
#include "pmlc/dialect/pxa/analysis/strides.h"
#include "pmlc/util/logging.h"

namespace pmlc::dialect::pxa {

using namespace mlir; // NOLINT

bool attemptFusion(AffineParallelOp op1, AffineParallelOp op2) {
  IVLOG(1, "W00t!");
  auto op1Write = getWriteBuffers(op1);
  auto op2Read = getReadBuffers(op2);
  for (auto buf : op1Write) {
    if (!op2Read.count(buf))
      continue;
    IVLOG(1, "Found a shared buf");
  }
  return false;
}

void fuseInner(Block &block) {
  auto it = block.begin();
  while (it != block.end()) {
    auto next = it;
    next++;
    if (next == block.end()) {
      break;
    }
    auto op1 = dyn_cast<AffineParallelOp>(*it);
    auto op2 = dyn_cast<AffineParallelOp>(*next);
    if (op1 && op2) {
      if (attemptFusion(op1, op2)) {
        continue;
      }
    }
    ++it;
  }
}

void FusePass::runOnFunction() {
  auto func = getFunction();
  fuseInner(func.getCallableRegion()->front());
}

} // namespace pmlc::dialect::pxa
