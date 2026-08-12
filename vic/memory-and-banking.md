---
type: reference
domain: vic
granularity: atomic
summary: "What the VIC-II can see: 16 KB bank select, screen matrix and charset placement."
keywords: [VIC bank, bank select, screen base, charset base, ROM holes]
---

## facts
- VIC-II reads from one 16 KB bank at a time; CIA2 `$DD00` bits `1-0` select that bank with inverted encoding.
- `$D018` selects the screen matrix base and the character or bitmap base inside the currently selected VIC bank.
- Character ROM is visible to VIC-II only in bank `0` at `$1000-$1FFF` and bank `2` at `$9000-$9FFF`.
- Color RAM stays at CPU-visible `$D800-$DBFF` and is not relocated by `$D018`.

## lookup

### VIC bank select via CIA2 `$DD00`
| `$DD00` bits `1-0` | VIC bank | VIC-visible range | notes |
|:---:|:---:|---|---|
| `%11` (`$03`) | `0` | `$0000-$3FFF` | KERNAL default after init; character ROM visible at `$1000-$1FFF`. |
| `%10` (`$02`) | `1` | `$4000-$7FFF` | No character ROM window. |
| `%01` (`$01`) | `2` | `$8000-$BFFF` | Character ROM visible at `$9000-$9FFF`. |
| `%00` (`$00`) | `3` | `$C000-$FFFF` | Highest VIC bank. |

### `$D018` pointer meanings
| field | bits | calculation inside VIC bank | use |
|---|:---:|---|---|
| Screen matrix base | `7-4` | `(value) × $0400` | Chooses the 1000-byte screen-code matrix. |
| Character / bitmap base | `3-1` | `(value) × $0800` | Chooses character data in character modes; bitmap modes only use bit `3`. |
| Unused | `0` | — | Not used by VIC-II addressing. |

### Common placement routes
| component | selected by | notes |
|---|---|---|
| Screen matrix | CIA2 bank + `$D018` bits `7-4` | Default route is `$0400-$07E7` in bank `0`. |
| Character data | CIA2 bank + `$D018` bits `3-1` | In standard text mode, the default route points at character ROM in bank `0`. |
| Bitmap data | CIA2 bank + `$D018` bit `3` | Bitmap base is `$0000` or `$2000` inside the active bank. |
| Color RAM | fixed `$D800-$DBFF` | Stores 4-bit color values per cell; not banked with the rest of VIC memory. |

## constraints
- `$DD02` bits `0-1` MUST be outputs before writing VIC bank bits through `$DD00`.
- Writes that change `$DD00` bank bits MUST preserve bits `2-7`, because they control serial-bus and user-port lines.
- All `$D018` calculations MUST be interpreted relative to the active VIC bank, not absolute CPU address zero.
- In bitmap modes, `$D018` bits `2-1` are ignored; only bit `3` selects bitmap base.
- Screen matrix, bitmap data, character data, and other assets inside a bank SHOULD be planned to avoid overlap.

## links
- VIC hub: [INDEX.md](INDEX.md)
- register summary: [registers.md](registers.md)
- timing: [timing.md](timing.md)
- screen modes: [screen-modes.md](screen-modes.md)
- screen-memory concept: [../concepts/screen-memory.md](../concepts/screen-memory.md)
- CIA2 bank select: [../io/cia2.md](../io/cia2.md)
- authoritative register table: [../io/vic-ii.md](../io/vic-ii.md)

## sources
- VIC hub: [INDEX.md](INDEX.md)
- screen-memory concept: [../concepts/screen-memory.md](../concepts/screen-memory.md)
- CIA2 register reference: [../io/cia2.md](../io/cia2.md)
- VIC-II register reference: [../io/vic-ii.md](../io/vic-ii.md)
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
