#map0 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1) -> (0, d0, d1)>
#map2 = affine_map<() -> (0)>
#map3 = affine_map<() -> (8192)>
#map4 = affine_map<() -> (3)>
#map5 = affine_map<() -> (2)>
#map6 = affine_map<(d0) -> (0, d0, 0)>
#map7 = affine_map<() -> (1)>


module {
  func @mult_plain(%arg0: memref<1x3x1xi64>, %arg1: memref<1x3x1xi64>, %arg2: memref<1x3x8192xi64>, %arg3: memref<2x3x8192xi64>, %arg4: memref<1x3x1xi64>, %arg5: memref<2x3x8192xi64>) {
    %c-1_i32 = constant -1 : i32
    %c32_i32 = constant 32 : i32
    %0 = alloc() : memref<1x3x1xi64>
    %1 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %8 = affine.load %arg3[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %9 = affine.load %arg2[0, %arg7, %arg8] : memref<1x3x8192xi64>
          %10 = muli %8, %9 : i64
          affine.store %10, %1[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %2 = alloc() : memref<2x3x8192xi64>
    %3 = alloc() : memref<1x3x1xi64>
    affine.for %arg6 = 0 to 1 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 1 {
          %8 = affine.load %arg1[0, %arg7, 0] : memref<1x3x1xi64>
          %9 = sexti %c-1_i32 : i32 to i64
          %10 = and %8, %9 : i64
          affine.store %10, %0[0, %arg7, 0] : memref<1x3x1xi64>
          %11 = affine.load %arg1[0, %arg7, 0] : memref<1x3x1xi64>
          %12 = sexti %c32_i32 : i32 to i64
          %13 = shift_right_unsigned %11, %12 : i64
          affine.store %13, %3[%arg6, %arg7, %arg8] : memref<1x3x1xi64>
        }
      }
    }
    %4 = alloc() : memref<2x3x8192xi64>
    %5 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %8 = affine.load %arg3[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %9 = affine.load %arg2[0, %arg7, %arg8] : memref<1x3x8192xi64>
          %10 = muli %8, %9 : i64
          %11 = affine.load %arg4[0, %arg7, 0] : memref<1x3x1xi64>
          %12 = muli %10, %11 : i64
          affine.store %12, %5[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %13 = sexti %c-1_i32 : i32 to i64
          %14 = and %10, %13 : i64
          affine.store %14, %2[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %15 = sexti %c32_i32 : i32 to i64
          %16 = shift_right_unsigned %10, %15 : i64
          affine.store %16, %4[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %6 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %8 = affine.load %2[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %9 = affine.load %3[0, %arg7, 0] : memref<1x3x1xi64>
          %10 = muli %8, %9 : i64
          %11 = affine.load %4[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %12 = affine.load %0[0, %arg7, 0] : memref<1x3x1xi64>
          %13 = muli %11, %12 : i64
          %14 = sexti %c-1_i32 : i32 to i64
          %15 = and %13, %14 : i64
          %16 = and %10, %14 : i64
          %17 = affine.load %2[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %18 = affine.load %0[0, %arg7, 0] : memref<1x3x1xi64>
          %19 = muli %17, %18 : i64
          %20 = affine.load %4[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %21 = affine.load %3[0, %arg7, 0] : memref<1x3x1xi64>
          %22 = muli %20, %21 : i64
          %23 = sexti %c32_i32 : i32 to i64
          %24 = shift_right_unsigned %13, %23 : i64
          %25 = addi %15, %16 : i64
          %26 = shift_right_unsigned %19, %23 : i64
          %27 = addi %22, %24 : i64
          %28 = shift_right_unsigned %10, %23 : i64
          %29 = addi %25, %26 : i64
          %30 = addi %27, %28 : i64
          %31 = shift_right_unsigned %29, %23 : i64
          %32 = addi %30, %31 : i64
          %33 = affine.load %5[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %34 = addi %33, %32 : i64
          affine.store %34, %6[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    %7 = alloc() : memref<2x3x8192xi64>
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %8 = affine.load %arg3[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %9 = sexti %c-1_i32 : i32 to i64
          %10 = and %8, %9 : i64
          %11 = affine.load %arg2[0, %arg7, %arg8] : memref<1x3x8192xi64>
          %12 = and %11, %9 : i64
          %13 = affine.load %arg3[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %14 = sexti %c32_i32 : i32 to i64
          %15 = shift_right_unsigned %13, %14 : i64
          %16 = affine.load %arg2[0, %arg7, %arg8] : memref<1x3x8192xi64>
          %17 = shift_right_unsigned %16, %14 : i64
          %18 = muli %12, %15 : i64
          %19 = muli %10, %17 : i64
          %20 = and %18, %9 : i64
          %21 = and %19, %9 : i64
          %22 = muli %10, %12 : i64
          %23 = addi %20, %21 : i64
          %24 = shift_right_unsigned %22, %14 : i64
          %25 = addi %23, %24 : i64
          %26 = muli %15, %17 : i64
          %27 = shift_right_unsigned %25, %14 : i64
          %28 = addi %26, %27 : i64
          %29 = shift_right_unsigned %18, %14 : i64
          %30 = addi %28, %29 : i64
          %31 = shift_right_unsigned %19, %14 : i64
          %32 = addi %30, %31 : i64
          affine.store %32, %7[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    affine.for %arg6 = 0 to 2 {
      affine.for %arg7 = 0 to 3 {
        affine.for %arg8 = 0 to 8192 {
          %8 = affine.load %7[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %9 = sexti %c32_i32 : i32 to i64
          %10 = shift_right_unsigned %8, %9 : i64
          %11 = affine.load %7[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %12 = sexti %c-1_i32 : i32 to i64
          %13 = and %11, %12 : i64
          %14 = affine.load %0[0, %arg7, 0] : memref<1x3x1xi64>
          %15 = muli %14, %10 : i64
          %16 = affine.load %3[0, %arg7, 0] : memref<1x3x1xi64>
          %17 = muli %13, %16 : i64
          %18 = affine.load %3[0, %arg7, 0] : memref<1x3x1xi64>
          %19 = muli %10, %18 : i64
          %20 = and %15, %12 : i64
          %21 = and %17, %12 : i64
          %22 = affine.load %0[0, %arg7, 0] : memref<1x3x1xi64>
          %23 = muli %13, %22 : i64
          %24 = addi %20, %21 : i64
          %25 = shift_right_unsigned %23, %9 : i64
          %26 = addi %24, %25 : i64
          %27 = shift_right_unsigned %26, %9 : i64
          %28 = addi %19, %27 : i64
          %29 = shift_right_unsigned %15, %9 : i64
          %30 = addi %28, %29 : i64
          %31 = shift_right_unsigned %17, %9 : i64
          %32 = affine.load %7[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %33 = affine.load %arg1[0, %arg7, 0] : memref<1x3x1xi64>
          %34 = muli %32, %33 : i64
          %35 = affine.load %6[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %36 = addi %35, %34 : i64
          %37 = affine.load %6[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %38 = cmpi "ult", %36, %37 : i64
          %39 = affine.load %arg4[0, %arg7, 0] : memref<1x3x1xi64>
          %40 = and %39, %12 : i64
          %41 = affine.load %arg4[0, %arg7, 0] : memref<1x3x1xi64>
          %42 = shift_right_unsigned %41, %9 : i64
          %43 = affine.load %4[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %44 = muli %40, %43 : i64
          %45 = affine.load %2[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %46 = muli %45, %42 : i64
          %47 = addi %30, %31 : i64
          %48 = zexti %38 : i1 to i64
          %49 = and %44, %12 : i64
          %50 = and %46, %12 : i64
          %51 = affine.load %2[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %52 = muli %51, %40 : i64
          %53 = addi %49, %50 : i64
          %54 = shift_right_unsigned %52, %9 : i64
          %55 = addi %53, %54 : i64
          %56 = affine.load %4[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %57 = muli %56, %42 : i64
          %58 = shift_right_unsigned %55, %9 : i64
          %59 = addi %57, %58 : i64
          %60 = shift_right_unsigned %44, %9 : i64
          %61 = addi %59, %60 : i64
          %62 = shift_right_unsigned %46, %9 : i64
          %63 = addi %61, %62 : i64
          %64 = affine.load %6[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %65 = affine.load %5[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %66 = cmpi "ult", %64, %65 : i64
          %67 = zexti %66 : i1 to i64
          %68 = affine.load %7[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %69 = affine.load %arg4[0, %arg7, 0] : memref<1x3x1xi64>
          %70 = muli %68, %69 : i64
          %71 = addi %63, %67 : i64
          %72 = addi %70, %71 : i64
          %73 = addi %47, %48 : i64
          %74 = addi %72, %73 : i64
          %75 = affine.load %arg0[0, %arg7, 0] : memref<1x3x1xi64>
          %76 = muli %74, %75 : i64
          %77 = affine.load %1[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
          %78 = subi %77, %76 : i64
          %79 = affine.load %arg0[0, %arg7, 0] : memref<1x3x1xi64>
          %80 = cmpi "uge", %78, %79 : i64
          %81 = zexti %80 : i1 to i64
          %82 = affine.load %arg0[0, %arg7, 0] : memref<1x3x1xi64>
          %83 = muli %81, %82 : i64
          %84 = subi %78, %83 : i64
          affine.store %84, %arg5[%arg6, %arg7, %arg8] : memref<2x3x8192xi64>
        }
      }
    }
    return
  }
}
