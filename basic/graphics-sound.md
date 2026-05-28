---
type: reference
domain: basic
granularity: route
---

## facts
- BASIC V2 has no native graphics or sound commands; effects are achieved via `POKE`/`PEEK` to VIC-II (`$D000-$D02E`) and SID (`$D400-$D418`).
- VIC-II border at `$D020`, background at `$D021-$D024`; values `0-15`.
- Screen RAM default at `$0400-$07E7` (40×25 = 1000 bytes of screen codes).
- Color RAM at `$D800-$DBE7` (1000 nybbles; low 4 bits = color `0-15`).
- SID master volume + filter mode at `$D418`; per-voice control register at `$D404`, `$D40B`, `$D412`.

## lookup

| effect | decimal | hex | values | route |
|---|---:|---:|---|---|
| Border color | `53280` | `$D020` | `0-15` | [../io/vic-ii.md](../io/vic-ii.md), [../colors/palette.md](../colors/palette.md) |
| Background 0 | `53281` | `$D021` | `0-15` | [../io/vic-ii.md](../io/vic-ii.md) |
| Background 1 (MCM/ECM) | `53282` | `$D022` | `0-15` | [../io/vic-ii.md](../io/vic-ii.md) |
| Background 2 (MCM/ECM) | `53283` | `$D023` | `0-15` | [../io/vic-ii.md](../io/vic-ii.md) |
| Background 3 (ECM only) | `53284` | `$D024` | `0-15` | [../io/vic-ii.md](../io/vic-ii.md) |
| Screen RAM start (default) | `1024` | `$0400` | screen-code bytes | [../charset/screen-codes.md](../charset/screen-codes.md) |
| Color RAM start | `55296` | `$D800` | low nybble `0-15` | [../io/color-ram.md](../io/color-ram.md), [../colors/palette.md](../colors/palette.md) |
| Sprite enable bitmap | `53269` | `$D015` | bit `n` per sprite | [../io/vic-ii.md](../io/vic-ii.md), [../tasks/sprite-display.md](../tasks/sprite-display.md) |
| Sprite 0 X | `53248` | `$D000` | `0-255` (+ MSB in `$D010`) | [../tasks/sprite-display.md](../tasks/sprite-display.md) |
| Sprite 0 Y | `53249` | `$D001` | `0-255` | [../tasks/sprite-display.md](../tasks/sprite-display.md) |
| Sprite 0 color | `53287` | `$D027` | `0-15` | [../tasks/sprite-display.md](../tasks/sprite-display.md) |
| VIC memory pointers (screen/charset bank) | `53272` | `$D018` | bit-packed | [../io/vic-ii.md](../io/vic-ii.md), `../tasks/custom-charset.md` (planned) |
| Raster line (read/compare) | `53266` | `$D012` | `0-255` (+ MSB in `$D011` bit 7) | [../io/vic-ii.md](../io/vic-ii.md), [../tasks/raster-interrupt.md](../tasks/raster-interrupt.md) |
| SID volume + filter mode | `54296` | `$D418` | low nybble = volume `0-15` | [../io/sid.md](../io/sid.md), `../tasks/play-sid.md` (planned) |
| SID voice 1 freq lo | `54272` | `$D400` | `0-255` | [../io/sid.md](../io/sid.md) |
| SID voice 1 freq hi | `54273` | `$D401` | `0-255` | [../io/sid.md](../io/sid.md) |
| SID voice 1 control | `54276` | `$D404` | gate + waveform bits | [../io/sid.md](../io/sid.md) |

## constraints
- VIC-II registers MUST use values `0-255`; bit operations require composing with `PEEK` first when changing single bits.
- Color RAM MUST be written nybble-wide; values above `15` are masked.
- Screen code bytes are NOT PETSCII; conversion routes via [../charset/screen-codes.md](../charset/screen-codes.md).
- SID writes are write-only (except `$D419-$D41C`); `PEEK` returns last write or `0`.
- SID volume `$D418` (`POKE 54296,15`) MUST be set before gating a voice or no sound is heard.
- `POKE` to `$D018` changes screen + charset base together; recompute when relocating either.
- Sprite operations require multiple register writes; see [../tasks/sprite-display.md](../tasks/sprite-display.md).

## examples

Black border, blue background:

```
10 POKE 53280,0 : POKE 53281,6
```

Fill screen with character `A` (screen code `1`) in white:

```
10 FOR I=0 TO 999 : POKE 1024+I,1 : POKE 55296+I,1 : NEXT
```

Beep voice 1 (triangle, gate on, then off):

```
10 POKE 54296,15 : POKE 54277,9 : POKE 54278,0
20 POKE 54273,30 : POKE 54272,0 : POKE 54276,17
30 FOR T=1 TO 500 : NEXT : POKE 54276,16
```

## links
- keywords: [keywords.md](keywords.md)
- functions: [functions.md](functions.md)
- examples: [examples.md](examples.md)
- VIC-II: [../io/vic-ii.md](../io/vic-ii.md)
- SID: [../io/sid.md](../io/sid.md)
- color RAM: [../io/color-ram.md](../io/color-ram.md)
- palette: [../colors/palette.md](../colors/palette.md)
- screen codes: [../charset/screen-codes.md](../charset/screen-codes.md)
- sprite task: [../tasks/sprite-display.md](../tasks/sprite-display.md)
- raster IRQ task: [../tasks/raster-interrupt.md](../tasks/raster-interrupt.md)
- memory map: [../memory/map.md](../memory/map.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md) (PRG 1982 for BASIC `POKE` recipes; mist64/c64ref `src/c64io` for register addresses)
- VIC-II registers: [../io/vic-ii.md](../io/vic-ii.md)
- SID registers: [../io/sid.md](../io/sid.md)
- BASIC index: [INDEX.md](INDEX.md)
