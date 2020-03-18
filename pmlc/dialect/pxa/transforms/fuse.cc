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
  auto op1Writes = getBufferWrites(op1);
  auto op2Reads = getBufferReads(op2);
  for (auto &kvp : op1Writes) {
    if (kvp.second.size() != 1)
      continue;
    auto kvp2 = op2Reads.find(kvp.first);
    if (kvp2 == op2Reads.end()) {
      continue;
    }
    if (kvp2->second.size() != 1) {
      continue;
    }

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
