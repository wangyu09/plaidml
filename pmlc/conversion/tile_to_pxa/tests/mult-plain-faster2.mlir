#map0 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<() -> (0)>
#map2 = affine_map<() -> (1)>
#map3 = affine_map<() -> (3)>
#map4 = affine_map<() -> (8192)>
#map5 = affine_map<() -> (2)>


module {
  func @mult_plain(%arg0: memref<1x3x1xi64>, %arg1: memref<1x3x1xi64>, %arg2: memref<1x3x8192xi64>, %arg3: memref<2x3x8192xi64>, %arg4: memref<1x3x1xi64>, %arg5: memref<2x3x8192xi64>) {
    %c-1_i32 = constant -1 : i32
    %c32_i32 = constant 32 : i32
    %0 = alloc() : memref<1x3x1xi64>
    affine.for %arg6 = 0 to 1 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 1 {
          %c0 = constant 0 : index
          %92 = affine.load %arg1[%c0, %arg7, %c0] : memref<1x3x1xi64>
          %93 = sexti %c-1_i32 : i32 to i64
          %94 = and %92, %93 : i64
          affine.store %94, %0[%arg6, %arg7, %arg8] : memref<1x3x1xi64>
        }
      }
    }
    %1 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %arg3[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %c0 = constant 0 : index
          %93 = affine.load %arg2[%c0, %arg7, %arg8] : memref<1x3x8192xi64>
          %94 = muli %92, %93 : i64
          affine.store %94, %1[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %2 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %1[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = sexti %c-1_i32 : i32 to i64
          %94 = and %92, %93 : i64
          affine.store %94, %2[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %3 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %2[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %c0 = constant 0 : index
          %93 = affine.load %0[%c0, %arg7, %c0] : memref<1x3x1xi64>
          %94 = muli %92, %93 : i64
          affine.store %94, %3[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %4 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %3[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = sexti %c32_i32 : i32 to i64
          %94 = shift_right_unsigned %92, %93 : i64
          affine.store %94, %4[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %5 = alloc() : memref<1x3x1xi64>
    affine.for %arg6 = 0 to 1 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 1 {
          %c0 = constant 0 : index
          %92 = affine.load %arg1[%c0, %arg7, %c0] : memref<1x3x1xi64>
          %93 = sexti %c32_i32 : i32 to i64
          %94 = shift_right_unsigned %92, %93 : i64
          affine.store %94, %5[%arg6, %arg7, %arg8] : memref<1x3x1xi64>
        }
      }
    }
    %6 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %2[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %c0 = constant 0 : index
          %93 = affine.load %5[%c0, %arg7, %c0] : memref<1x3x1xi64>
          %94 = muli %92, %93 : i64
          affine.store %94, %6[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %7 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %6[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = sexti %c-1_i32 : i32 to i64
          %94 = and %92, %93 : i64
          affine.store %94, %7[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %8 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %1[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = sexti %c32_i32 : i32 to i64
          %94 = shift_right_unsigned %92, %93 : i64
          affine.store %94, %8[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %9 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %8[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %c0 = constant 0 : index
          %93 = affine.load %0[%c0, %arg7, %c0] : memref<1x3x1xi64>
          %94 = muli %92, %93 : i64
          affine.store %94, %9[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %10 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %9[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = sexti %c-1_i32 : i32 to i64
          %94 = and %92, %93 : i64
          affine.store %94, %10[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %11 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %10[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = affine.load %7[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %94 = addi %92, %93 : i64
          affine.store %94, %11[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %12 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %11[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = affine.load %4[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %94 = addi %92, %93 : i64
          affine.store %94, %12[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %13 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %12[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = sexti %c32_i32 : i32 to i64
          %94 = shift_right_unsigned %92, %93 : i64
          affine.store %94, %13[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %14 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %6[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = sexti %c32_i32 : i32 to i64
          %94 = shift_right_unsigned %92, %93 : i64
          affine.store %94, %14[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %15 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %9[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = sexti %c32_i32 : i32 to i64
          %94 = shift_right_unsigned %92, %93 : i64
          affine.store %94, %15[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %16 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %8[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %c0 = constant 0 : index
          %93 = affine.load %5[%c0, %arg7, %c0] : memref<1x3x1xi64>
          %94 = muli %92, %93 : i64
          affine.store %94, %16[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %17 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %16[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = affine.load %15[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %94 = addi %92, %93 : i64
          affine.store %94, %17[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %18 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %17[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = affine.load %14[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %94 = addi %92, %93 : i64
          affine.store %94, %18[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %19 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %18[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = affine.load %13[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %94 = addi %92, %93 : i64
          affine.store %94, %19[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %20 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %1[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %c0 = constant 0 : index
          %93 = affine.load %arg4[%c0, %arg7, %c0] : memref<1x3x1xi64>
          %94 = muli %92, %93 : i64
          affine.store %94, %20[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %21 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %20[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = affine.load %19[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %94 = addi %92, %93 : i64
          affine.store %94, %21[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %22 = alloc() : memref<1x3x8192xi64>
    affine.for %arg6 = 0 to 1 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %c0 = constant 0 : index
          %92 = affine.load %arg2[%c0, %arg7, %arg8] : memref<1x3x8192xi64>
          %93 = sexti %c32_i32 : i32 to i64
          %94 = shift_right_unsigned %92, %93 : i64
          affine.store %94, %22[%arg6, %arg7, %arg8] : memref<1x3x8192xi64>
        }
      }
    }
    %23 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %arg3[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = sexti %c-1_i32 : i32 to i64
          %94 = and %92, %93 : i64
          affine.store %94, %23[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %24 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %23[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %c0 = constant 0 : index
          %93 = affine.load %22[%c0, %arg7, %arg8] : memref<1x3x8192xi64>
          %94 = muli %92, %93 : i64
          affine.store %94, %24[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %25 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %24[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = sexti %c32_i32 : i32 to i64
          %94 = shift_right_unsigned %92, %93 : i64
          affine.store %94, %25[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %26 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %arg3[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = sexti %c32_i32 : i32 to i64
          %94 = shift_right_unsigned %92, %93 : i64
          affine.store %94, %26[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %27 = alloc() : memref<1x3x8192xi64>
    affine.for %arg6 = 0 to 1 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %c0 = constant 0 : index
          %92 = affine.load %arg2[%c0, %arg7, %arg8] : memref<1x3x8192xi64>
          %93 = sexti %c-1_i32 : i32 to i64
          %94 = and %92, %93 : i64
          affine.store %94, %27[%arg6, %arg7, %arg8] : memref<1x3x8192xi64>
        }
      }
    }
    %28 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %c0 = constant 0 : index
          %92 = affine.load %27[%c0, %arg7, %arg8] : memref<1x3x8192xi64>
          %93 = affine.load %26[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %94 = muli %92, %93 : i64
          affine.store %94, %28[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %29 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %28[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = sexti %c32_i32 : i32 to i64
          %94 = shift_right_unsigned %92, %93 : i64
          affine.store %94, %29[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %30 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %23[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %c0 = constant 0 : index
          %93 = affine.load %27[%c0, %arg7, %arg8] : memref<1x3x8192xi64>
          %94 = muli %92, %93 : i64
          affine.store %94, %30[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %31 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %30[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = sexti %c32_i32 : i32 to i64
          %94 = shift_right_unsigned %92, %93 : i64
          affine.store %94, %31[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %32 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %24[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = sexti %c-1_i32 : i32 to i64
          %94 = and %92, %93 : i64
          affine.store %94, %32[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %33 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %28[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = sexti %c-1_i32 : i32 to i64
          %94 = and %92, %93 : i64
          affine.store %94, %33[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %34 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %33[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = affine.load %32[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %94 = addi %92, %93 : i64
          affine.store %94, %34[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %35 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %34[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = affine.load %31[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %94 = addi %92, %93 : i64
          affine.store %94, %35[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %36 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %35[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = sexti %c32_i32 : i32 to i64
          %94 = shift_right_unsigned %92, %93 : i64
          affine.store %94, %36[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %37 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %26[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %c0 = constant 0 : index
          %93 = affine.load %22[%c0, %arg7, %arg8] : memref<1x3x8192xi64>
          %94 = muli %92, %93 : i64
          affine.store %94, %37[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %38 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %37[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = affine.load %36[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %94 = addi %92, %93 : i64
          affine.store %94, %38[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %39 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %38[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = affine.load %29[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %94 = addi %92, %93 : i64
          affine.store %94, %39[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %40 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %39[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = affine.load %25[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %94 = addi %92, %93 : i64
          affine.store %94, %40[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %41 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %40[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %c0 = constant 0 : index
          %93 = affine.load %arg1[%c0, %arg7, %c0] : memref<1x3x1xi64>
          %94 = muli %92, %93 : i64
          affine.store %94, %41[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %42 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %21[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = affine.load %41[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %94 = addi %92, %93 : i64
          affine.store %94, %42[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %43 = alloc() : memref<2x3x8192xi1>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %42[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = affine.load %21[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %94 = cmpi "ult", %92, %93 : i64
          affine.store %94, %43[%arg6, %arg7, %arg8] : memref<2x3x8192xi1>
        }
      }
    }
    %44 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %43[%arg6, %arg7, %arg8] : memref<2x3x8192xi1>
          %93 = zexti %92 : i1 to i64
          affine.store %93, %44[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %45 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %40[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = sexti %c-1_i32 : i32 to i64
          %94 = and %92, %93 : i64
          affine.store %94, %45[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %46 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %45[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %c0 = constant 0 : index
          %93 = affine.load %5[%c0, %arg7, %c0] : memref<1x3x1xi64>
          %94 = muli %92, %93 : i64
          affine.store %94, %46[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %47 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %46[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = sexti %c32_i32 : i32 to i64
          %94 = shift_right_unsigned %92, %93 : i64
          affine.store %94, %47[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %48 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %40[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = sexti %c32_i32 : i32 to i64
          %94 = shift_right_unsigned %92, %93 : i64
          affine.store %94, %48[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %49 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %c0 = constant 0 : index
          %92 = affine.load %0[%c0, %arg7, %c0] : memref<1x3x1xi64>
          %93 = affine.load %48[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %94 = muli %92, %93 : i64
          affine.store %94, %49[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %50 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %49[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = sexti %c32_i32 : i32 to i64
          %94 = shift_right_unsigned %92, %93 : i64
          affine.store %94, %50[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %51 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %45[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %c0 = constant 0 : index
          %93 = affine.load %0[%c0, %arg7, %c0] : memref<1x3x1xi64>
          %94 = muli %92, %93 : i64
          affine.store %94, %51[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %52 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %51[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = sexti %c32_i32 : i32 to i64
          %94 = shift_right_unsigned %92, %93 : i64
          affine.store %94, %52[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %53 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %46[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = sexti %c-1_i32 : i32 to i64
          %94 = and %92, %93 : i64
          affine.store %94, %53[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %54 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %49[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = sexti %c-1_i32 : i32 to i64
          %94 = and %92, %93 : i64
          affine.store %94, %54[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %55 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %54[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = affine.load %53[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %94 = addi %92, %93 : i64
          affine.store %94, %55[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %56 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %55[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = affine.load %52[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %94 = addi %92, %93 : i64
          affine.store %94, %56[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %57 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %56[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = sexti %c32_i32 : i32 to i64
          %94 = shift_right_unsigned %92, %93 : i64
          affine.store %94, %57[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %58 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %48[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %c0 = constant 0 : index
          %93 = affine.load %5[%c0, %arg7, %c0] : memref<1x3x1xi64>
          %94 = muli %92, %93 : i64
          affine.store %94, %58[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %59 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %58[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = affine.load %57[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %94 = addi %92, %93 : i64
          affine.store %94, %59[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %60 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %59[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = affine.load %50[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %94 = addi %92, %93 : i64
          affine.store %94, %60[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %61 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %60[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = affine.load %47[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %94 = addi %92, %93 : i64
          affine.store %94, %61[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %62 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %61[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = affine.load %44[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %94 = addi %92, %93 : i64
          affine.store %94, %62[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %63 = alloc() : memref<2x3x8192xi1>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %21[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = affine.load %20[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %94 = cmpi "ult", %92, %93 : i64
          affine.store %94, %63[%arg6, %arg7, %arg8] : memref<2x3x8192xi1>
        }
      }
    }
    %64 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %63[%arg6, %arg7, %arg8] : memref<2x3x8192xi1>
          %93 = zexti %92 : i1 to i64
          affine.store %93, %64[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %65 = alloc() : memref<1x3x1xi64>
    affine.for %arg6 = 0 to 1 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 1 {
          %c0 = constant 0 : index
          %92 = affine.load %arg4[%c0, %arg7, %c0] : memref<1x3x1xi64>
          %93 = sexti %c32_i32 : i32 to i64
          %94 = shift_right_unsigned %92, %93 : i64
          affine.store %94, %65[%arg6, %arg7, %arg8] : memref<1x3x1xi64>
        }
      }
    }
    %66 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %2[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %c0 = constant 0 : index
          %93 = affine.load %65[%c0, %arg7, %c0] : memref<1x3x1xi64>
          %94 = muli %92, %93 : i64
          affine.store %94, %66[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %67 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %66[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = sexti %c32_i32 : i32 to i64
          %94 = shift_right_unsigned %92, %93 : i64
          affine.store %94, %67[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %68 = alloc() : memref<1x3x1xi64>
    affine.for %arg6 = 0 to 1 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 1 {
          %c0 = constant 0 : index
          %92 = affine.load %arg4[%c0, %arg7, %c0] : memref<1x3x1xi64>
          %93 = sexti %c-1_i32 : i32 to i64
          %94 = and %92, %93 : i64
          affine.store %94, %68[%arg6, %arg7, %arg8] : memref<1x3x1xi64>
        }
      }
    }
    %69 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %c0 = constant 0 : index
          %92 = affine.load %68[%c0, %arg7, %c0] : memref<1x3x1xi64>
          %93 = affine.load %8[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %94 = muli %92, %93 : i64
          affine.store %94, %69[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %70 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %69[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = sexti %c32_i32 : i32 to i64
          %94 = shift_right_unsigned %92, %93 : i64
          affine.store %94, %70[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %71 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %2[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %c0 = constant 0 : index
          %93 = affine.load %68[%c0, %arg7, %c0] : memref<1x3x1xi64>
          %94 = muli %92, %93 : i64
          affine.store %94, %71[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %72 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %71[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = sexti %c32_i32 : i32 to i64
          %94 = shift_right_unsigned %92, %93 : i64
          affine.store %94, %72[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %73 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %66[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = sexti %c-1_i32 : i32 to i64
          %94 = and %92, %93 : i64
          affine.store %94, %73[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %74 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %69[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = sexti %c-1_i32 : i32 to i64
          %94 = and %92, %93 : i64
          affine.store %94, %74[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %75 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %74[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = affine.load %73[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %94 = addi %92, %93 : i64
          affine.store %94, %75[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %76 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %75[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = affine.load %72[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %94 = addi %92, %93 : i64
          affine.store %94, %76[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %77 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %76[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = sexti %c32_i32 : i32 to i64
          %94 = shift_right_unsigned %92, %93 : i64
          affine.store %94, %77[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %78 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %8[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %c0 = constant 0 : index
          %93 = affine.load %65[%c0, %arg7, %c0] : memref<1x3x1xi64>
          %94 = muli %92, %93 : i64
          affine.store %94, %78[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %79 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %78[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = affine.load %77[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %94 = addi %92, %93 : i64
          affine.store %94, %79[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %80 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %79[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = affine.load %70[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %94 = addi %92, %93 : i64
          affine.store %94, %80[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %81 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %80[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = affine.load %67[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %94 = addi %92, %93 : i64
          affine.store %94, %81[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %82 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %81[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = affine.load %64[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %94 = addi %92, %93 : i64
          affine.store %94, %82[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %83 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %40[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %c0 = constant 0 : index
          %93 = affine.load %arg4[%c0, %arg7, %c0] : memref<1x3x1xi64>
          %94 = muli %92, %93 : i64
          affine.store %94, %83[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %84 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %83[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = affine.load %82[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %94 = addi %92, %93 : i64
          affine.store %94, %84[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %85 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %84[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = affine.load %62[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %94 = addi %92, %93 : i64
          affine.store %94, %85[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %86 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %85[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %c0 = constant 0 : index
          %93 = affine.load %arg0[%c0, %arg7, %c0] : memref<1x3x1xi64>
          %94 = muli %92, %93 : i64
          affine.store %94, %86[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %87 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %1[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = affine.load %86[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %94 = subi %92, %93 : i64
          affine.store %94, %87[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %88 = alloc() : memref<2x3x8192xi1>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %87[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %c0 = constant 0 : index
          %93 = affine.load %arg0[%c0, %arg7, %c0] : memref<1x3x1xi64>
          %94 = cmpi "uge", %92, %93 : i64
          affine.store %94, %88[%arg6, %arg7, %arg8] : memref<2x3x8192xi1>
        }
      }
    }
    %89 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %88[%arg6, %arg7, %arg8] : memref<2x3x8192xi1>
          %93 = zexti %92 : i1 to i64
          affine.store %93, %89[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %90 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %89[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %c0 = constant 0 : index
          %93 = affine.load %arg0[%c0, %arg7, %c0] : memref<1x3x1xi64>
          %94 = muli %92, %93 : i64
          affine.store %94, %90[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %91 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %92 = affine.load %87[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %93 = affine.load %90[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %94 = subi %92, %93 : i64
          affine.store %94, %arg5[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    return
  }
}
