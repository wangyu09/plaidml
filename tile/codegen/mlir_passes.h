// Copyright 2019, Intel Corporation

#pragma once

#include "tile/codegen/compile_pass.h"

namespace vertexai {
namespace tile {
namespace codegen {

void ConvertFromMLIR(CompilerState* state);
void ConvertIntoMLIR(CompilerState* state);
void DumpMLIR(const CompilerState& state, std::ostream* stream);

}  // namespace codegen
}  // namespace tile
}  // namespace vertexai
