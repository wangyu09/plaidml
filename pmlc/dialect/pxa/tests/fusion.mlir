// RUN: pmlc-opt -canonicalize -fusion %s | FileCheck %s

module {
  func @eltwise_fuse(%arg0: memref<100x100xf32>, %arg1: memref<100x100xf32>) {
    %tmp = alloc() : memref<100x100xf32> 
    affine.parallel (%i, %j) = (0, 0) to (100, 100) {
      %0 = affine.load %arg1[%i, %j] : memref<100x100xf32>
      %1 = sqrt %0 : f32
      affine.store %1, %tmp[%i, %j] : memref<100x100xf32>
    }
    affine.parallel (%i, %j) = (0, 0) to (100, 100) {
      %0 = affine.load %tmp[%i, %j] : memref<100x100xf32>
      %1 = constant 1.0 : f32
      %2 = addf %0, %1 : f32
      affine.store %2, %arg0[%i, %j] : memref<100x100xf32>
    }
    return
  }
}

