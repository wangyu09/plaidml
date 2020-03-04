// Copyright 2020, Intel Corporation

#include "pmlc/dialect/pxa/analysis/read_write.h"
#include "mlir/ADT/TypeSwitch.h"
#include "mlir/Dialect/StandardOps/Ops.h"
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

DenseSet<Value> getReadBuffers(Operation *base) {
  DenseSet<Value> r;
  base->walk([&](Operation *op) {
    TypeSwitch<Operation *>(op)
        .Case<AffineLoadOp>(
            [&](auto op) { r.insert(getBufferSource(op.getMemRef())); })
        .Case<AffineReduceOp>(
            [&](auto op) { r.insert(getBufferSource(op.out())); });
  });
  return r;
}

DenseSet<Value> getWriteBuffers(Operation *base) {
  DenseSet<Value> r;
  base->walk([&](Operation *op) {
    TypeSwitch<Operation *>(op)
        .Case<AffineStoreOp>(
            [&](auto op) { r.insert(getBufferSource(op.getMemRef())); })
        .Case<AffineReduceOp>(
            [&](auto op) { r.insert(getBufferSource(op.out())); });
  });
  return r;
}

} // namespace mlir
