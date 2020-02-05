#map0 = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0) -> (d0, 0)>
#map2 = affine_map<() -> (0)>
#map3 = affine_map<() -> (8192)>
#map4 = affine_map<() -> (3)>


module {
  func @add_plain(%arg0: memref<3x1xi64>, %arg1: memref<3x8192xi64>, %arg2: memref<3x8192xi64>, %arg3: memref<3x8192xi64>) {
    affine.for %arg4 = 0 to 3 {
      affine.for %arg5 = 0 to 8192 {
        %0 = affine.load %arg2[%arg4, %arg5] : memref<3x8192xi64>
        %1 = affine.load %arg1[%arg4, %arg5] : memref<3x8192xi64>
        %2 = addi %0, %1 : i64
        %3 = affine.load %arg0[%arg4, 0] : memref<3x1xi64>
        %4 = cmpi "uge", %2, %3 : i64
        %5 = zexti %4 : i1 to i64
        %6 = affine.load %arg0[%arg4, 0] : memref<3x1xi64>
        %7 = muli %5, %6 : i64
        %8 = subi %2, %7 : i64
        affine.store %8, %arg3[%arg4, %arg5] : memref<3x8192xi64>
      }
    }
    return
  }
}
