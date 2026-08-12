---
type: reference
domain: tools
granularity: graphics-editors
summary: "Editors for charsets, tiles, sprites and bitmap graphics."
keywords: [graphics editors, CharPad, SpritePad, Pixcen, pixel editor]
---

## facts
- CharPad and SpritePad Pro are the most widely used cross-platform tools for C64 charset/tile and sprite work respectively.
- Both are by Subchrist Software; CharPad has a free version; SpritePad Pro is paid.
- Native graphics tools are catalogued separately at codebase64.net `vic:gfx_editors_and_converters`.

## lookup — cross-platform editors
| tool | author | primary use |
|---|---|---|
| CharPad | Subchrist Software | Charset design, tile maps, color attribute editing. |
| SpritePad Pro | Subchrist Software | Sprite drawing, animation, overlay editing. |
| Pixcen | CRT | Multicolor and hires pixel art; PETSCII support. |
| Project One | Oswald | High-resolution and multicolor bitmap editor. |
| Timanthes | Mirage | FLI, multicolor, hires bitmap editor. |
| OxPaint | Oxidy | Bitmap painting tool. |
| HermIRES | Hermit | IFLI / interlaced bitmap editor. |

## constraints
- Output format varies per tool; verify the target display mode before choosing an editor.
- SpritePad Pro exports raw sprite data; caller must place data at a VIC-accessible address aligned to the sprite pointer block.
- CharPad tile maps encode attributes separately from char data; loading order matters for display.

## sources

- CharPad: https://subchristsoftware.itch.io/charpad-c64-free
- SpritePad Pro: https://subchristsoftware.itch.io/spritepad-c64-pro
- Pixcen: http://hammarberg.github.io/pixcen/
- Project One: https://csdb.dk/release/?id=39261
- Timanthes: https://csdb.dk/release/?id=75871
- OxPaint: https://csdb.dk/release/?id=52822
- HermIRES: https://csdb.dk/release/?id=128693
- native GFX editors (codebase64.net): https://codebase64.net/doku.php?id=vic:gfx_editors_and_converters
- codebase64.net tools page: https://codebase64.net/doku.php?id=tools:start (CC BY-NC-SA 4.0)
- display modes: [../display-modes/INDEX.md](../display-modes/INDEX.md)
- sprites: [../sprites/INDEX.md](../sprites/INDEX.md)
- graphics modes reference: [../graphics/INDEX.md](../graphics/INDEX.md)
- VIC-II overview: [../vic/INDEX.md](../vic/INDEX.md)
