//./bazel-bin/pmlc/tools/pmlc-opt/pmlc-opt ./pmlc/conversion/tile_to_pxa/tests/relu.mlir -convert-tile-to-pxa -convert-pxa-to-affine -affine-loop-fusion

#map0 = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<() -> (0)>
#map2 = affine_map<() -> (20)>
#map3 = affine_map<() -> (10)>


module {
  func @relu(%arg0: memref<10x20xf32>, %arg1: memref<10x20xf32>) {
    %cst = constant 0.000000e+00 : f32
    %0 = alloc() : memref<10x20xi1>
    affine.for %arg2 = 0 to 10 {
      affine.for %arg3 = 0 to 20 {
        %2 = affine.load %arg0[%arg2, %arg3] : memref<10x20xf32>
        %3 = cmpf "olt", %2, %cst : f32
        affine.store %3, %0[%arg2, %arg3] : memref<10x20xi1>
      }
    }
    %1 = alloc() : memref<10x20xf32>
    affine.for %arg2 = 0 to 10 {
      affine.for %arg3 = 0 to 20 {
        %2 = affine.load %0[%arg2, %arg3] : memref<10x20xi1>
        %3 = affine.load %arg0[%arg2, %arg3] : memref<10x20xf32>
        %4 = select %2, %cst, %3 : f32
        affine.store %4, %arg1[%arg2, %arg3] : memref<10x20xf32>
      }
    }
    return
  }
}
