// Copyright 2020 Intel Corporation

#pragma once

#include "mlir/Pass/Pass.h"

namespace pmlc::dialect::pxa {

struct FusePass : public mlir::FunctionPass<FusePass> {
  void runOnFunction() override;
};

} // namespace pmlc::dialect::pxa
