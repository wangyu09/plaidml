module {
  func @add_plain(%arg0: memref<3x1xi64>, %arg1: memref<3x8192xi64>, %arg2: memref<3x8192xi64>, %arg3: memref<3x8192xi64>) {
    %0 = alloc() : memref<3x8192xi64>
    affine.for %arg4 = 0 to 3 {
      affine.for %arg5 = 0 to 8192 {
        %4 = affine.load %arg2[%arg4, %arg5] : memref<3x8192xi64>
        %5 = affine.load %arg1[%arg4, %arg5] : memref<3x8192xi64>
        %6 = addi %4, %5 : i64
        affine.store %6, %0[%arg4, %arg5] : memref<3x8192xi64>
      }
    }
    %1 = alloc() : memref<3x8192xi1>
    affine.for %arg4 = 0 to 3 {
      affine.for %arg5 = 0 to 8192 {
        %4 = affine.load %0[%arg4, %arg5] : memref<3x8192xi64>
        %5 = affine.load %arg0[%arg4, 0] : memref<3x1xi64>
        %6 = cmpi "uge", %4, %5 : i64
        affine.store %6, %1[%arg4, %arg5] : memref<3x8192xi1>
      }
    }
    %2 = alloc() : memref<3x8192xi64>
    affine.for %arg4 = 0 to 3 {
      affine.for %arg5 = 0 to 8192 {
        %4 = affine.load %1[%arg4, %arg5] : memref<3x8192xi1>
        %5 = zexti %4 : i1 to i64
        affine.store %5, %2[%arg4, %arg5] : memref<3x8192xi64>
      }
    }
    %3 = alloc() : memref<3x8192xi64>
    affine.for %arg4 = 0 to 3 {
      affine.for %arg5 = 0 to 8192 {
        %4 = affine.load %2[%arg4, %arg5] : memref<3x8192xi64>
        %5 = affine.load %arg0[%arg4, 0] : memref<3x1xi64>
        %6 = muli %4, %5 : i64
        affine.store %6, %3[%arg4, %arg5] : memref<3x8192xi64>
      }
    }
    affine.for %arg4 = 0 to 3 {
      affine.for %arg5 = 0 to 8192 {
        %4 = affine.load %0[%arg4, %arg5] : memref<3x8192xi64>
        %5 = affine.load %3[%arg4, %arg5] : memref<3x8192xi64>
        %6 = subi %4, %5 : i64
        affine.store %6, %arg3[%arg4, %arg5] : memref<3x8192xi64>
      }
    }
    return
  }
}
