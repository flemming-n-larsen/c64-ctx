---
type: reference
domain: algorithms
granularity: atomic
---

## facts
- 3D on the C64 uses fixed-point integer arithmetic throughout; typical precision is Q8.8 or Q4.4.
- Rotation is applied via a 3×3 matrix of precomputed sine/cosine values (updated per frame, not per vertex).
- Perspective projection maps a 3D point to 2D screen coordinates: `screen_x = focal * x / z`, `screen_y = focal * y / z`.
- Backface culling tests the sign of the dot product of the face normal with the view vector to skip hidden faces.
- For the full rendering pipeline (scanline fill, painter's algorithm, speedcode clear) see [../effects/vectors.md](../effects/vectors.md).

## lookup
Rotation matrix (angles α around X, β around Y, γ around Z):
```
Rx = [ 1      0       0    ]
     [ 0   cos(α)  -sin(α) ]
     [ 0   sin(α)   cos(α) ]

Ry = [ cos(β)  0  sin(β) ]
     [   0     1    0    ]
     [-sin(β)  0  cos(β) ]

Rz = [ cos(γ)  -sin(γ)  0 ]
     [ sin(γ)   cos(γ)  0 ]
     [   0        0     1 ]
```
Combined R = Rx × Ry × Rz; 9 coefficients cached as fixed-point values.

| step | operation | input | output | notes |
|---|---|---|---|---|
| 1. Rotate | R × [x,y,z] | world coords | rotated coords | 9 multiply+add |
| 2. Translate | add camera offset | rotated | view-space | 3 adds |
| 3. Project | x' = f*x/z, y' = f*y/z | view-space | screen 2D | 2 divides; `z` must be > 0 |
| 4. Clip | reject if x',y' outside viewport | screen 2D | — | optional |
| 5. Cull | dot(normal, view) < 0 → skip face | normals | face visible flag | 3 multiply+add |

## sequence
Perspective divide (fixed-point, focal `f` = 128):
```
; x_view in A (signed), z_view in Z_VAR (positive)
; result in A = screen_x offset from center

    LDA x_view
    JSR signed_mul_128   ; A = x * focal (16-bit result)
    ; divide by z (z_view in denominator)
    JSR div16_by_z       ; quotient → A
    CLC
    ADC #160             ; add screen center X (160 = half of 320)
    STA screen_x
```

Backface culling (face normal [nx, ny, nz], view vector [0,0,1] for simple front-facing):
```
; If nz > 0 → face points toward viewer (front-facing)
    LDA normal_z
    BPL face_visible     ; bit 7 = 0 → positive → front-facing
    ; face is back-facing, skip
    JMP next_face
face_visible:
    ; proceed to render
```

Full dot product backface cull (view_vec = [vx, vy, vz]):
```
; dot = nx*vx + ny*vy + nz*vz
; if dot > 0 → front-facing (depends on normal convention)
    LDA nx : JSR mul_vx  ; partial product 1
    CLC : ADC ny_vy_prod : ADC nz_vz_prod
    BPL face_visible
```

## constraints
- `z` MUST be positive before perspective divide; a zero or negative `z` causes divide-by-zero or inverted projection.
- Fixed-point precision loss accumulates through the rotation-project pipeline; use Q8.8 minimum for acceptable visual quality.
- Pre-compute the rotation matrix coefficients once per frame, not once per vertex; 9 multiplies per vertex vs. 9 per frame.
- Backface culling normal convention (inward vs. outward) MUST be consistent with the face winding order used during model definition.
- See [../effects/vectors.md](../effects/vectors.md) for the complete polygon fill and rendering pipeline on C64.

## links
- math: [../math/multiply.md](../math/multiply.md)
- math: [../math/trig.md](../math/trig.md)
- math: [../math/fixed-point.md](../math/fixed-point.md)
- math: [../math/divide.md](../math/divide.md)
- effects: [../effects/vectors.md](../effects/vectors.md)

## sources
- codebase64.net: [3D rotation](https://codebase64.net/doku.php?id=base:3d_rotation) — CC BY-NC-SA 4.0
- codebase64.net: [Perspective](https://codebase64.net/doku.php?id=base:perspective) — CC BY-NC-SA 4.0
- codebase64.net: [Backface culling](https://codebase64.net/doku.php?id=base:backface_culling) — CC BY-NC-SA 4.0
- codebase64.net: [Filling the vectors](https://codebase64.net/doku.php?id=base:filling_the_vectors) — CC BY-NC-SA 4.0
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
