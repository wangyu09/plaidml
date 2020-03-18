// Copyright 2020, Intel Corporation

#pragma once

#include "mlir/Dialect/AffineOps/AffineOps.h"
#include "llvm/ADT/DenseSet.h"

#include "pmlc/dialect/pxa/ir/ops.h"

namespace mlir {

// Gets the initial allocation or block argument of a memref: i.e. walk though
// subviews, etc, until we hit the source of memref
Value getBufferSource(Value buf);

DenseMap<Value, SmallVector<Operation *, 2>> getBufferReads(Operation *op);
DenseMap<Value, SmallVector<Operation *, 2>> getBufferWrites(Operation *op);

} // namespace mlir
