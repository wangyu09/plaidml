#README

Save the below as `relu.mlir`
```
!f32 = type tensor<!eltwise.f32>
!t_10x20xfp32 = type tensor<10x20x!eltwise.f32>
!t_10x20xbool = type tensor<10x20x!eltwise.u1>

func @relu(%arg0: !t_10x20xfp32) -> !t_10x20xfp32 {
  %0 = "eltwise.sconst"() {value = 0.0 : f32} : () -> !f32
  %1 = "eltwise.cmp_lt"(%arg0, %0) : (!t_10x20xfp32, !f32) -> !t_10x20xbool
  %2 = "eltwise.select"(%1, %0, %arg0) : (!t_10x20xbool, !f32, !t_10x20xfp32) -> !t_10x20xfp32
  return %2 : !t_10x20xfp32
}
```


1)
```pmlc-opt ./pmlc/conversion/tile_to_pxa/tests/relu.mlir -convert-tile-to-pxa -canonicalize -convert-pxa-to-affine -affine-loop-fusion```
yields

```
#map0 = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<() -> (0, 0)>
#map2 = affine_map<() -> (0)>
#map3 = affine_map<() -> (20)>
#map4 = affine_map<() -> (10)>


module {
  func @relu(%arg0: memref<10x20xf32>, %arg1: memref<10x20xf32>) {
    %0 = alloc() : memref<1x1xi1>
    %cst = constant 0.000000e+00 : f32
    affine.for %arg2 = 0 to 10 {
      affine.for %arg3 = 0 to 20 {
        %1 = affine.load %arg0[%arg2, %arg3] : memref<10x20xf32>
        %2 = cmpf "olt", %1, %cst : f32
        affine.store %2, %0[0, 0] : memref<1x1xi1>
        %3 = affine.load %0[0, 0] : memref<1x1xi1>
        %4 = affine.load %arg0[%arg2, %arg3] : memref<10x20xf32>
        %5 = select %3, %cst, %4 : f32
        affine.store %5, %arg1[%arg2, %arg3] : memref<10x20xf32>
      }
    }
    return
  }
```
