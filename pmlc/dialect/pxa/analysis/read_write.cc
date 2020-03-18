// Copyright 2020, Intel Corporation

#include "pmlc/dialect/pxa/analysis/read_write.h"
#include "mlir/ADT/TypeSwitch.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "pmlc/util/logging.h"

using pmlc::dialect::pxa::AffineReduceOp;

namespace mlir {

Value getBufferSource(Value buf) {
  assert(buf.getType().isa<MemRefType>());
  while (true) {
    Operation *op = buf.getDefiningOp();
    // TODO: Anything I'm forgetting?
    if (auto subOp = mlir::dyn_cast_or_null<SubViewOp>(op)) {
      buf = subOp.source();
      continue;
    }
    break;
  }
  return buf;
}

DenseMap<Value, SmallVector<Operation *, 2>> getBufferReads(Operation *base) {
  DenseMap<Value, SmallVector<Operation *, 2>> ret;
  base->walk([&](Operation *baseOp) {
    TypeSwitch<Operation *>(baseOp)
        .Case<AffineLoadOp>([&](auto op) {
          ret[getBufferSource(op.getMemRef())].push_back(op);
        })
        .Case<AffineReduceOp>(
            [&](auto op) { ret[getBufferSource(op.out())].push_back(op); });
  });
  return ret;
}

DenseMap<Value, SmallVector<Operation *, 2>> getBufferWrites(Operation *base) {
  DenseMap<Value, SmallVector<Operation *, 2>> ret;
  base->walk([&](Operation *baseOp) {
    TypeSwitch<Operation *>(baseOp)
        .Case<AffineStoreOp>([&](auto op) {
          ret[getBufferSource(op.getMemRef())].push_back(op);
        })
        .Case<AffineReduceOp>(
            [&](auto op) { ret[getBufferSource(op.out())].push_back(op); });
  });
  return ret;
}

} // namespace mlir
