// pmlc-opt pmlc/conversion/tile_to_pxa/tests/relu-cpp-edsl-pre-loop-fusion.mlir -canonicalize -affine-loop-fusion -canonicalize

module {
  func @relu(%arg0: memref<10x20xf32>, %arg1: memref<10x20xf32>) {
    %cst = constant 0.000000e+00 : f32
    %0 = alloc() : memref<10x20xi1>
    %c0 = constant 0 : index
    %c10 = constant 10 : index
    %c1 = constant 1 : index
    loop.for %arg2 = %c0 to %c10 step %c1 {
      %c0_3 = constant 0 : index
      %c20 = constant 20 : index
      %c1_4 = constant 1 : index
      loop.for %arg3 = %c0_3 to %c20 step %c1_4 {
        %1 = load %arg0[%arg2, %arg3] : memref<10x20xf32>
        %2 = cmpf "olt", %1, %cst : f32
        store %2, %0[%arg2, %arg3] : memref<10x20xi1>
      }
    }
    %c0_0 = constant 0 : index
    %c10_1 = constant 10 : index
    %c1_2 = constant 1 : index
    loop.for %arg2 = %c0_0 to %c10_1 step %c1_2 {
      %c0_3 = constant 0 : index
      %c20 = constant 20 : index
      %c1_4 = constant 1 : index
      loop.for %arg3 = %c0_3 to %c20 step %c1_4 {
        %1 = load %0[%arg2, %arg3] : memref<10x20xi1>
        %2 = load %arg0[%arg2, %arg3] : memref<10x20xf32>
        %3 = select %1, %cst, %2 : f32
        store %3, %arg1[%arg2, %arg3] : memref<10x20xf32>
      }
    }
    return
  }
}
