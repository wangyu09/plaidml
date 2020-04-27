#pragma once

#include "mlir/Pass/Pass.h"

namespace pmlc::conversion::gpu {

#define GEN_PASS_CLASSES
#include "pmlc/conversion/gpu_to_vulkan/passes.h.inc"

} // namespace pmlc::conversion::gpu
