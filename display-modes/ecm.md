---
type: reference
domain: display-modes
granularity: atomic
---

## facts
- ECM (Extended Color Mode, also called Extended Background Color Mode) is the official VIC-II character-mode combination `ECM=1`, `BMM=0`, `MCM=0`.
- In ECM, screen-code bits `7-6` select one of the four background registers `$D021`-`$D024`, while bits `5-0` select glyph `0-63` from the active character set.
- Foreground color still comes from color RAM at `$D800+cell`, so ECM changes background selection rules without turning character mode into bitmap mode.
- The practical trade-off is a hard `64`-glyph limit per charset, but the mode keeps a hires-style character look that modern game authors sometimes prefer over multicolor blockiness.
- The linked Kodiak article is useful as modern-game context and examples of ECM-heavy presentation, not as a register-level hardware contract.

## sequence

1. Preserve non-mode bits in `$D011` and `$D016`, especially scroll and display-enable state.
2. Enable ECM by setting `$D011` bit `6`, clearing `$D011` bit `5`, and clearing `$D016` bit `4`.
3. Select the VIC bank with CIA2 `$DD00` and point `$D018` at the intended screen RAM and character-set base.
4. Fill screen RAM so bits `7-6` choose the background register and bits `5-0` choose the glyph number.
5. Write foreground colors to color RAM and the four shared background colors to `$D021`-`$D024`.

## lookup

### Register and memory roles

| item | role in ECM | notes |
|---|---|---|
| `$D011` bit `6` | `ECM` enable | MUST be `1` for ECM |
| `$D011` bit `5` | `BMM` | MUST stay `0` for visible ECM |
| `$D016` bit `4` | `MCM` | MUST stay `0` for visible ECM |
| `$D021-$D024` | shared background colors | selected by screen-code bits `7-6` |
| color RAM `$D800+cell` | foreground color | one nibble per character cell |
| `$D018` | screen/charset base | same character-mode addressing rules as standard text mode |

### Screen-code layout

| bits `7-6` | bits `5-0` | result |
|---|---|---|
| `00` | `0-63` | use `$D021` and glyph `0-63` |
| `01` | `0-63` | use `$D022` and glyph `0-63` |
| `10` | `0-63` | use `$D023` and glyph `0-63` |
| `11` | `0-63` | use `$D024` and glyph `0-63` |

### Route map

| need | read | notes |
|---|---|---|
| Official mode matrix and color-source table | [../graphics/screen-modes.md](../graphics/screen-modes.md) | Canonical local table for all `ECM/BMM/MCM` combinations. |
| Raw VIC-II register ownership | [../io/vic-ii.md](../io/vic-ii.md) | `$D011`, `$D016`, `$D018`, and `$D021-$D024`. |
| VIC-first mode routing | [../vic/screen-modes.md](../vic/screen-modes.md) | Places ECM beside the other official hardware modes. |
| Charset preparation workflow | [../tasks/custom-charset.md](../tasks/custom-charset.md) | Useful when the `64`-glyph ECM limit is intentional. |
| Interlaced ECM variant | [eci.md](eci.md) | ECI builds on ECM by alternating `$D021-$D024` between frames. |

## constraints
- ECM reduces the usable character set to `64` glyphs; screen codes `64-255` do not add new glyph shapes, they only change the selected background register.
- Visible ECM requires `ECM=1`, `BMM=0`, `MCM=0`; the other `ECM=1` combinations are listed locally as illegal modes.
- `$D018` addressing and CIA2 bank selection still apply exactly as in other character modes; ECM does not remove banking constraints.
- Keep `PETSCII`, screen codes, and charset glyph indices separate when building content pipelines for ECM screens.
- Treat modern-game examples as design inspiration only; exact hardware behavior should come from the cited local graphics and I/O pages.

## links
- display-modes index: [INDEX.md](INDEX.md)
- official mode table: [../graphics/screen-modes.md](../graphics/screen-modes.md)
- VIC mode route: [../vic/screen-modes.md](../vic/screen-modes.md)
- VIC-II registers: [../io/vic-ii.md](../io/vic-ii.md)
- custom charset task: [../tasks/custom-charset.md](../tasks/custom-charset.md)
- ECI: [eci.md](eci.md)
- provenance: [../sources/INDEX.md](../sources/INDEX.md)

## sources
- official mode table: [../graphics/screen-modes.md](../graphics/screen-modes.md)
- VIC mode route: [../vic/screen-modes.md](../vic/screen-modes.md)
- VIC-II registers: [../io/vic-ii.md](../io/vic-ii.md)
- custom charset task: [../tasks/custom-charset.md](../tasks/custom-charset.md)
- ECI: [eci.md](eci.md)
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
