#map0 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<() -> (0)>
#map2 = affine_map<() -> (8192)>
#map3 = affine_map<() -> (3)>
#map4 = affine_map<() -> (2)>
#map5 = affine_map<(d0) -> (0, d0, 0)>


module {
  func @add_cipher(%arg0: memref<1x3x1xi64>, %arg1: memref<2x3x8192xi64>, %arg2: memref<2x3x8192xi64>, %arg3: memref<2x3x8192xi64>) {
    %0 = alloc() : memref<2x3x8192xi64>
    affine.for %arg4 = 0 to 2 {
      affine.for %arg5 = 0 to 3 {
        affine.for %arg6 = 0 to 8192 {
          %4 = affine.load %arg2[%arg4, %arg5, %arg6] : memref<2x3x8192xi64>
          %5 = affine.load %arg1[%arg4, %arg5, %arg6] : memref<2x3x8192xi64>
          %6 = addi %4, %5 : i64
          affine.store %6, %0[%arg4, %arg5, %arg6] : memref<2x3x8192xi64>
        }
      }
    }
    %1 = alloc() : memref<2x3x8192xi1>
    affine.for %arg4 = 0 to 2 {
      affine.for %arg5 = 0 to 3 {
        affine.for %arg6 = 0 to 8192 {
          %4 = affine.load %0[%arg4, %arg5, %arg6] : memref<2x3x8192xi64>
          %5 = affine.load %arg0[0, %arg5, 0] : memref<1x3x1xi64>
          %6 = cmpi "uge", %4, %5 : i64
          affine.store %6, %1[%arg4, %arg5, %arg6] : memref<2x3x8192xi1>
        }
      }
    }
    %2 = alloc() : memref<2x3x8192xi64>
    affine.for %arg4 = 0 to 2 {
      affine.for %arg5 = 0 to 3 {
        affine.for %arg6 = 0 to 8192 {
          %4 = affine.load %1[%arg4, %arg5, %arg6] : memref<2x3x8192xi1>
          %5 = zexti %4 : i1 to i64
          affine.store %5, %2[%arg4, %arg5, %arg6] : memref<2x3x8192xi64>
        }
      }
    }
    %3 = alloc() : memref<2x3x8192xi64>
    affine.for %arg4 = 0 to 2 {
      affine.for %arg5 = 0 to 3 {
        affine.for %arg6 = 0 to 8192 {
          %4 = affine.load %2[%arg4, %arg5, %arg6] : memref<2x3x8192xi64>
          %5 = affine.load %arg0[0, %arg5, 0] : memref<1x3x1xi64>
          %6 = muli %4, %5 : i64
          affine.store %6, %3[%arg4, %arg5, %arg6] : memref<2x3x8192xi64>
        }
      }
    }
    affine.for %arg4 = 0 to 2 {
      affine.for %arg5 = 0 to 3 {
        affine.for %arg6 = 0 to 8192 {
          %4 = affine.load %0[%arg4, %arg5, %arg6] : memref<2x3x8192xi64>
          %5 = affine.load %3[%arg4, %arg5, %arg6] : memref<2x3x8192xi64>
          %6 = subi %4, %5 : i64
          affine.store %6, %arg3[%arg4, %arg5, %arg6] : memref<2x3x8192xi64>
        }
      }
    }
    return
  }
}
