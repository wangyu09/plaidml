#map0 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<() -> (0)>
#map2 = affine_map<() -> (1)>
#map3 = affine_map<() -> (3)>
#map4 = affine_map<(d0, d1) -> (0, d0, d1)>
#map5 = affine_map<() -> (8192)>
#map6 = affine_map<() -> (2)>
#map7 = affine_map<(d0) -> (0, d0, 0)>


module {
  func @mult_plain(%arg0: memref<1x3x1xi64>, %arg1: memref<1x3x1xi64>, %arg2: memref<1x3x8192xi64>, %arg3: memref<2x3x8192xi64>, %arg4: memref<1x3x1xi64>, %arg5: memref<2x3x8192xi64>) {
    %c32_i32 = constant 32 : i32
    %0 = alloc() : memref<1x3x1xi32>
    affine.for %arg6 = 0 to 1 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 1 {
          %111 = affine.load %arg1[%arg6, %arg7, %arg8] : memref<1x3x1xi64>
          %112 = trunci %111 : i64 to i32
          affine.store %112, %0[%arg6, %arg7, %arg8] : memref<1x3x1xi32>
        }
      }
    }
    %1 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %arg3[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %arg2[0, %arg7, %arg8] : memref<1x3x8192xi64>
          %113 = muli %111, %112 : i64
          affine.store %113, %1[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %2 = alloc() : memref<2x3x8192xi32>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %1[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = trunci %111 : i64 to i32
          affine.store %112, %2[%arg6, %arg7, %arg8] : memref<2x3x8192xi32>
        }
      }
    }
    %3 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %2[%arg6, %arg7, %arg8] : memref<2x3x8192xi32>
          %112 = zexti %111 : i32 to i64
          affine.store %112, %3[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %4 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %3[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %0[0, %arg7, 0] : memref<1x3x1xi32>
          %113 = zexti %112 : i32 to i64
          %114 = muli %111, %113 : i64
          affine.store %114, %4[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %5 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %4[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = sexti %c32_i32 : i32 to i64
          %113 = shift_right_unsigned %111, %112 : i64
          affine.store %113, %5[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %6 = alloc() : memref<1x3x1xi64>
    affine.for %arg6 = 0 to 1 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 1 {
          %111 = affine.load %arg1[0, %arg7, 0] : memref<1x3x1xi64>
          %112 = sexti %c32_i32 : i32 to i64
          %113 = shift_right_unsigned %111, %112 : i64
          affine.store %113, %6[%arg6, %arg7, %arg8] : memref<1x3x1xi64>
        }
      }
    }
    %7 = alloc() : memref<1x3x1xi32>
    affine.for %arg6 = 0 to 1 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 1 {
          %111 = affine.load %6[%arg6, %arg7, %arg8] : memref<1x3x1xi64>
          %112 = trunci %111 : i64 to i32
          affine.store %112, %7[%arg6, %arg7, %arg8] : memref<1x3x1xi32>
        }
      }
    }
    %8 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %3[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %7[0, %arg7, 0] : memref<1x3x1xi32>
          %113 = zexti %112 : i32 to i64
          %114 = muli %111, %113 : i64
          affine.store %114, %8[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %9 = alloc() : memref<2x3x8192xi32>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %8[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = trunci %111 : i64 to i32
          affine.store %112, %9[%arg6, %arg7, %arg8] : memref<2x3x8192xi32>
        }
      }
    }
    %10 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %9[%arg6, %arg7, %arg8] : memref<2x3x8192xi32>
          %112 = zexti %111 : i32 to i64
          affine.store %112, %10[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %11 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %1[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = sexti %c32_i32 : i32 to i64
          %113 = shift_right_unsigned %111, %112 : i64
          affine.store %113, %11[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %12 = alloc() : memref<2x3x8192xi32>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %11[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = trunci %111 : i64 to i32
          affine.store %112, %12[%arg6, %arg7, %arg8] : memref<2x3x8192xi32>
        }
      }
    }
    %13 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %12[%arg6, %arg7, %arg8] : memref<2x3x8192xi32>
          %112 = zexti %111 : i32 to i64
          affine.store %112, %13[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %14 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %13[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %0[0, %arg7, 0] : memref<1x3x1xi32>
          %113 = zexti %112 : i32 to i64
          %114 = muli %111, %113 : i64
          affine.store %114, %14[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %15 = alloc() : memref<2x3x8192xi32>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %14[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = trunci %111 : i64 to i32
          affine.store %112, %15[%arg6, %arg7, %arg8] : memref<2x3x8192xi32>
        }
      }
    }
    %16 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %15[%arg6, %arg7, %arg8] : memref<2x3x8192xi32>
          %112 = zexti %111 : i32 to i64
          affine.store %112, %16[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %17 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %16[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %10[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %113 = addi %111, %112 : i64
          affine.store %113, %17[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %18 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %17[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %5[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %113 = addi %111, %112 : i64
          affine.store %113, %18[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %19 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %18[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = sexti %c32_i32 : i32 to i64
          %113 = shift_right_unsigned %111, %112 : i64
          affine.store %113, %19[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %20 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %8[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = sexti %c32_i32 : i32 to i64
          %113 = shift_right_unsigned %111, %112 : i64
          affine.store %113, %20[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %21 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %14[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = sexti %c32_i32 : i32 to i64
          %113 = shift_right_unsigned %111, %112 : i64
          affine.store %113, %21[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %22 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %13[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %7[0, %arg7, 0] : memref<1x3x1xi32>
          %113 = zexti %112 : i32 to i64
          %114 = muli %111, %113 : i64
          affine.store %114, %22[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %23 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %22[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %21[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %113 = addi %111, %112 : i64
          affine.store %113, %23[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %24 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %23[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %20[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %113 = addi %111, %112 : i64
          affine.store %113, %24[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %25 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %24[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %19[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %113 = addi %111, %112 : i64
          affine.store %113, %25[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %26 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %1[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %arg4[0, %arg7, 0] : memref<1x3x1xi64>
          %113 = muli %111, %112 : i64
          affine.store %113, %26[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %27 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %26[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %25[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %113 = addi %111, %112 : i64
          affine.store %113, %27[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %28 = alloc() : memref<1x3x8192xi32>
    affine.for %arg6 = 0 to 1 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %arg2[%arg6, %arg7, %arg8] : memref<1x3x8192xi64>
          %112 = trunci %111 : i64 to i32
          affine.store %112, %28[%arg6, %arg7, %arg8] : memref<1x3x8192xi32>
        }
      }
    }
    %29 = alloc() : memref<2x3x8192xi32>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %arg3[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = trunci %111 : i64 to i32
          affine.store %112, %29[%arg6, %arg7, %arg8] : memref<2x3x8192xi32>
        }
      }
    }
    %30 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %29[%arg6, %arg7, %arg8] : memref<2x3x8192xi32>
          %112 = zexti %111 : i32 to i64
          affine.store %112, %30[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %31 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %30[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %28[0, %arg7, %arg8] : memref<1x3x8192xi32>
          %113 = zexti %112 : i32 to i64
          %114 = muli %111, %113 : i64
          affine.store %114, %31[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %32 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %31[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = sexti %c32_i32 : i32 to i64
          %113 = shift_right_unsigned %111, %112 : i64
          affine.store %113, %32[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %33 = alloc() : memref<1x3x8192xi64>
    affine.for %arg6 = 0 to 1 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %arg2[0, %arg7, %arg8] : memref<1x3x8192xi64>
          %112 = sexti %c32_i32 : i32 to i64
          %113 = shift_right_unsigned %111, %112 : i64
          affine.store %113, %33[%arg6, %arg7, %arg8] : memref<1x3x8192xi64>
        }
      }
    }
    %34 = alloc() : memref<1x3x8192xi32>
    affine.for %arg6 = 0 to 1 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %33[%arg6, %arg7, %arg8] : memref<1x3x8192xi64>
          %112 = trunci %111 : i64 to i32
          affine.store %112, %34[%arg6, %arg7, %arg8] : memref<1x3x8192xi32>
        }
      }
    }
    %35 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %30[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %34[0, %arg7, %arg8] : memref<1x3x8192xi32>
          %113 = zexti %112 : i32 to i64
          %114 = muli %111, %113 : i64
          affine.store %114, %35[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %36 = alloc() : memref<2x3x8192xi32>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %35[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = trunci %111 : i64 to i32
          affine.store %112, %36[%arg6, %arg7, %arg8] : memref<2x3x8192xi32>
        }
      }
    }
    %37 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %36[%arg6, %arg7, %arg8] : memref<2x3x8192xi32>
          %112 = zexti %111 : i32 to i64
          affine.store %112, %37[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %38 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %arg3[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = sexti %c32_i32 : i32 to i64
          %113 = shift_right_unsigned %111, %112 : i64
          affine.store %113, %38[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %39 = alloc() : memref<2x3x8192xi32>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %38[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = trunci %111 : i64 to i32
          affine.store %112, %39[%arg6, %arg7, %arg8] : memref<2x3x8192xi32>
        }
      }
    }
    %40 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %39[%arg6, %arg7, %arg8] : memref<2x3x8192xi32>
          %112 = zexti %111 : i32 to i64
          affine.store %112, %40[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %41 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %40[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %28[0, %arg7, %arg8] : memref<1x3x8192xi32>
          %113 = zexti %112 : i32 to i64
          %114 = muli %111, %113 : i64
          affine.store %114, %41[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %42 = alloc() : memref<2x3x8192xi32>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %41[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = trunci %111 : i64 to i32
          affine.store %112, %42[%arg6, %arg7, %arg8] : memref<2x3x8192xi32>
        }
      }
    }
    %43 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %42[%arg6, %arg7, %arg8] : memref<2x3x8192xi32>
          %112 = zexti %111 : i32 to i64
          affine.store %112, %43[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %44 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %43[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %37[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %113 = addi %111, %112 : i64
          affine.store %113, %44[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %45 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %44[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %32[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %113 = addi %111, %112 : i64
          affine.store %113, %45[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %46 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %45[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = sexti %c32_i32 : i32 to i64
          %113 = shift_right_unsigned %111, %112 : i64
          affine.store %113, %46[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %47 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %35[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = sexti %c32_i32 : i32 to i64
          %113 = shift_right_unsigned %111, %112 : i64
          affine.store %113, %47[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %48 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %41[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = sexti %c32_i32 : i32 to i64
          %113 = shift_right_unsigned %111, %112 : i64
          affine.store %113, %48[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %49 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %40[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %34[0, %arg7, %arg8] : memref<1x3x8192xi32>
          %113 = zexti %112 : i32 to i64
          %114 = muli %111, %113 : i64
          affine.store %114, %49[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %50 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %49[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %48[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %113 = addi %111, %112 : i64
          affine.store %113, %50[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %51 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %50[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %47[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %113 = addi %111, %112 : i64
          affine.store %113, %51[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %52 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %51[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %46[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %113 = addi %111, %112 : i64
          affine.store %113, %52[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %53 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %52[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %arg1[0, %arg7, 0] : memref<1x3x1xi64>
          %113 = muli %111, %112 : i64
          affine.store %113, %53[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %54 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %27[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %53[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %113 = addi %111, %112 : i64
          affine.store %113, %54[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %55 = alloc() : memref<2x3x8192xi1>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %54[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %27[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %113 = cmpi "ult", %111, %112 : i64
          affine.store %113, %55[%arg6, %arg7, %arg8] : memref<2x3x8192xi1>
        }
      }
    }
    %56 = alloc() : memref<2x3x8192xi8>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %55[%arg6, %arg7, %arg8] : memref<2x3x8192xi1>
          %112 = zexti %111 : i1 to i8
          affine.store %112, %56[%arg6, %arg7, %arg8] : memref<2x3x8192xi8>
        }
      }
    }
    %57 = alloc() : memref<2x3x8192xi32>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %52[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = trunci %111 : i64 to i32
          affine.store %112, %57[%arg6, %arg7, %arg8] : memref<2x3x8192xi32>
        }
      }
    }
    %58 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %57[%arg6, %arg7, %arg8] : memref<2x3x8192xi32>
          %112 = zexti %111 : i32 to i64
          affine.store %112, %58[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %59 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %58[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %0[0, %arg7, 0] : memref<1x3x1xi32>
          %113 = zexti %112 : i32 to i64
          %114 = muli %111, %113 : i64
          affine.store %114, %59[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %60 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %59[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = sexti %c32_i32 : i32 to i64
          %113 = shift_right_unsigned %111, %112 : i64
          affine.store %113, %60[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %61 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %58[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %7[0, %arg7, 0] : memref<1x3x1xi32>
          %113 = zexti %112 : i32 to i64
          %114 = muli %111, %113 : i64
          affine.store %114, %61[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %62 = alloc() : memref<2x3x8192xi32>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %61[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = trunci %111 : i64 to i32
          affine.store %112, %62[%arg6, %arg7, %arg8] : memref<2x3x8192xi32>
        }
      }
    }
    %63 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %62[%arg6, %arg7, %arg8] : memref<2x3x8192xi32>
          %112 = zexti %111 : i32 to i64
          affine.store %112, %63[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %64 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %52[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = sexti %c32_i32 : i32 to i64
          %113 = shift_right_unsigned %111, %112 : i64
          affine.store %113, %64[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %65 = alloc() : memref<2x3x8192xi32>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %64[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = trunci %111 : i64 to i32
          affine.store %112, %65[%arg6, %arg7, %arg8] : memref<2x3x8192xi32>
        }
      }
    }
    %66 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %65[%arg6, %arg7, %arg8] : memref<2x3x8192xi32>
          %112 = zexti %111 : i32 to i64
          affine.store %112, %66[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %67 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %66[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %0[0, %arg7, 0] : memref<1x3x1xi32>
          %113 = zexti %112 : i32 to i64
          %114 = muli %111, %113 : i64
          affine.store %114, %67[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %68 = alloc() : memref<2x3x8192xi32>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %67[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = trunci %111 : i64 to i32
          affine.store %112, %68[%arg6, %arg7, %arg8] : memref<2x3x8192xi32>
        }
      }
    }
    %69 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %68[%arg6, %arg7, %arg8] : memref<2x3x8192xi32>
          %112 = zexti %111 : i32 to i64
          affine.store %112, %69[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %70 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %69[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %63[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %113 = addi %111, %112 : i64
          affine.store %113, %70[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %71 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %70[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %60[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %113 = addi %111, %112 : i64
          affine.store %113, %71[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %72 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %71[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = sexti %c32_i32 : i32 to i64
          %113 = shift_right_unsigned %111, %112 : i64
          affine.store %113, %72[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %73 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %61[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = sexti %c32_i32 : i32 to i64
          %113 = shift_right_unsigned %111, %112 : i64
          affine.store %113, %73[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %74 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %67[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = sexti %c32_i32 : i32 to i64
          %113 = shift_right_unsigned %111, %112 : i64
          affine.store %113, %74[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %75 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %66[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %7[0, %arg7, 0] : memref<1x3x1xi32>
          %113 = zexti %112 : i32 to i64
          %114 = muli %111, %113 : i64
          affine.store %114, %75[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %76 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %75[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %74[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %113 = addi %111, %112 : i64
          affine.store %113, %76[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %77 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %76[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %73[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %113 = addi %111, %112 : i64
          affine.store %113, %77[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %78 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %77[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %72[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %113 = addi %111, %112 : i64
          affine.store %113, %78[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %79 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %78[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %56[%arg6, %arg7, %arg8] : memref<2x3x8192xi8>
          %113 = zexti %112 : i8 to i64
          %114 = addi %111, %113 : i64
          affine.store %114, %79[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %80 = alloc() : memref<2x3x8192xi1>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %27[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %26[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %113 = cmpi "ult", %111, %112 : i64
          affine.store %113, %80[%arg6, %arg7, %arg8] : memref<2x3x8192xi1>
        }
      }
    }
    %81 = alloc() : memref<2x3x8192xi8>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %80[%arg6, %arg7, %arg8] : memref<2x3x8192xi1>
          %112 = zexti %111 : i1 to i8
          affine.store %112, %81[%arg6, %arg7, %arg8] : memref<2x3x8192xi8>
        }
      }
    }
    %82 = alloc() : memref<1x3x1xi32>
    affine.for %arg6 = 0 to 1 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 1 {
          %111 = affine.load %arg4[%arg6, %arg7, %arg8] : memref<1x3x1xi64>
          %112 = trunci %111 : i64 to i32
          affine.store %112, %82[%arg6, %arg7, %arg8] : memref<1x3x1xi32>
        }
      }
    }
    %83 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %3[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %82[0, %arg7, 0] : memref<1x3x1xi32>
          %113 = zexti %112 : i32 to i64
          %114 = muli %111, %113 : i64
          affine.store %114, %83[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %84 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %83[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = sexti %c32_i32 : i32 to i64
          %113 = shift_right_unsigned %111, %112 : i64
          affine.store %113, %84[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %85 = alloc() : memref<1x3x1xi64>
    affine.for %arg6 = 0 to 1 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 1 {
          %111 = affine.load %arg4[0, %arg7, 0] : memref<1x3x1xi64>
          %112 = sexti %c32_i32 : i32 to i64
          %113 = shift_right_unsigned %111, %112 : i64
          affine.store %113, %85[%arg6, %arg7, %arg8] : memref<1x3x1xi64>
        }
      }
    }
    %86 = alloc() : memref<1x3x1xi32>
    affine.for %arg6 = 0 to 1 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 1 {
          %111 = affine.load %85[%arg6, %arg7, %arg8] : memref<1x3x1xi64>
          %112 = trunci %111 : i64 to i32
          affine.store %112, %86[%arg6, %arg7, %arg8] : memref<1x3x1xi32>
        }
      }
    }
    %87 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %3[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %86[0, %arg7, 0] : memref<1x3x1xi32>
          %113 = zexti %112 : i32 to i64
          %114 = muli %111, %113 : i64
          affine.store %114, %87[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %88 = alloc() : memref<2x3x8192xi32>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %87[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = trunci %111 : i64 to i32
          affine.store %112, %88[%arg6, %arg7, %arg8] : memref<2x3x8192xi32>
        }
      }
    }
    %89 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %88[%arg6, %arg7, %arg8] : memref<2x3x8192xi32>
          %112 = zexti %111 : i32 to i64
          affine.store %112, %89[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %90 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %13[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %82[0, %arg7, 0] : memref<1x3x1xi32>
          %113 = zexti %112 : i32 to i64
          %114 = muli %111, %113 : i64
          affine.store %114, %90[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %91 = alloc() : memref<2x3x8192xi32>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %90[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = trunci %111 : i64 to i32
          affine.store %112, %91[%arg6, %arg7, %arg8] : memref<2x3x8192xi32>
        }
      }
    }
    %92 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %91[%arg6, %arg7, %arg8] : memref<2x3x8192xi32>
          %112 = zexti %111 : i32 to i64
          affine.store %112, %92[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %93 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %92[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %89[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %113 = addi %111, %112 : i64
          affine.store %113, %93[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %94 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %93[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %84[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %113 = addi %111, %112 : i64
          affine.store %113, %94[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %95 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %94[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = sexti %c32_i32 : i32 to i64
          %113 = shift_right_unsigned %111, %112 : i64
          affine.store %113, %95[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %96 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %87[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = sexti %c32_i32 : i32 to i64
          %113 = shift_right_unsigned %111, %112 : i64
          affine.store %113, %96[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %97 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %90[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = sexti %c32_i32 : i32 to i64
          %113 = shift_right_unsigned %111, %112 : i64
          affine.store %113, %97[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %98 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %13[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %86[0, %arg7, 0] : memref<1x3x1xi32>
          %113 = zexti %112 : i32 to i64
          %114 = muli %111, %113 : i64
          affine.store %114, %98[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %99 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %98[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %97[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %113 = addi %111, %112 : i64
          affine.store %113, %99[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %100 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %99[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %96[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %113 = addi %111, %112 : i64
          affine.store %113, %100[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %101 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %100[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %95[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %113 = addi %111, %112 : i64
          affine.store %113, %101[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %102 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %101[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %81[%arg6, %arg7, %arg8] : memref<2x3x8192xi8>
          %113 = zexti %112 : i8 to i64
          %114 = addi %111, %113 : i64
          affine.store %114, %102[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %103 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %52[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %arg4[0, %arg7, 0] : memref<1x3x1xi64>
          %113 = muli %111, %112 : i64
          affine.store %113, %103[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %104 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %103[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %102[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %113 = addi %111, %112 : i64
          affine.store %113, %104[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %105 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %104[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %79[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %113 = addi %111, %112 : i64
          affine.store %113, %105[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %106 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %105[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %arg0[0, %arg7, 0] : memref<1x3x1xi64>
          %113 = muli %111, %112 : i64
          affine.store %113, %106[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %107 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %1[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %106[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %113 = subi %111, %112 : i64
          affine.store %113, %107[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %108 = alloc() : memref<2x3x8192xi1>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %107[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %arg0[0, %arg7, 0] : memref<1x3x1xi64>
          %113 = cmpi "uge", %111, %112 : i64
          affine.store %113, %108[%arg6, %arg7, %arg8] : memref<2x3x8192xi1>
        }
      }
    }
    %109 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %108[%arg6, %arg7, %arg8] : memref<2x3x8192xi1>
          %112 = zexti %111 : i1 to i64
          affine.store %112, %109[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %110 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %109[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %arg0[0, %arg7, 0] : memref<1x3x1xi64>
          %113 = muli %111, %112 : i64
          affine.store %113, %110[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %111 = affine.load %107[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %112 = affine.load %110[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %113 = subi %111, %112 : i64
          affine.store %113, %arg5[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    return
  }
}
