# Attribution

This repository is licensed under **CC BY-NC-SA 4.0**
(Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International).
Full license text: https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode

This repository derives facts, data, and structure from the following upstream sources.

## mist64/c64ref

- Repository: https://github.com/mist64/c64ref
- Author: Michael Steil
- License: BSD 2-Clause

The CPU reference, memory map, I/O register data, KERNAL API, BASIC/KERNAL ROM
disassembly routes, character set data, and color palette in this repository are
extracted or derived from mist64/c64ref.

CPU instruction timing (cycle counts), opcode bytes, and addressing-mode data in
`cpu/6502/instruction-set.md` and `cpu/6502/addressing-modes.md` are derived from
`src/6502` in this repository.

I/O register data for VIC-II (`io/vic-ii.md`), SID (`sid/registers.md`), CIA1 (`io/cia1.md`),
and CIA2 (`io/cia2.md`) — including register addresses, bit fields, and timing notes —
is derived from `src/c64io` in this repository. The curated `vic/` pages and the
sprite hardware summaries in `sprites/registers.md` and `sprites/display.md` route
these same local facts without replacing the underlying register references.

BASIC token byte values in `basic/tokens.md`, `basic/keywords.md`, and `basic/functions.md`,
along with BASIC ROM routine routing in `basic/routines.md` and `rom/basic-disassembly.md`,
are derived from `src/c64disasm` in this repository.

Charset facts in `charset/petscii.md`, `charset/screen-codes.md`,
`charset/control-codes.md`, and `charset/keyboard-matrix.md` — including PETSCII
byte ranges, control-code names, screen-code conversion rules, and 8×8 keyboard
matrix positions — are derived from `src/charset` in this repository.

Memory facts in `memory/map.md`, `memory/symbols.md`, and `memory/zero-page.md` —
including sub-region ranges, KERNAL/BASIC workspace symbols, page-3 indirect
vectors, and CPU hardware vectors at `$FFFA-$FFFF` — are derived from `src/c64mem`
in this repository.

Full license text (reproduced as required by BSD 2-Clause):

```
BSD 2-Clause License

Copyright (c) 2022, Michael Steil
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
```

## Rebecca Bettencourt — charset interchange maps

- Files: `src/charset/C64IPRI.TXT`, `src/charset/C64IALT.TXT` (in mist64/c64ref)
- Author: Rebecca Bettencourt <support@kreativekorp.com>
- Dates: 2018-04-20 (primary), 2018-10-11 (alternate)

The Unicode name mappings used in `charset/chargen-primary.md` and
`charset/chargen-alternate.md` are derived from these files, distributed as
part of mist64/c64ref under the BSD 2-Clause license above.

## Illegal / undocumented opcode behavior

Opcode bytes and mnemonic assignments in `cpu/6502/illegal-opcodes.md` are
sourced from mist64/c64ref (see above). Stability classifications, behavioral
notes, and quirks are derived from the following community reference documents:

- **"NMOS 6510 Unintended Opcodes"** — No More Secrets (2010).
  The definitive community reference for undocumented 6510 opcode behavior,
  stability, and flag effects.
- **"64doc"** — John West and Marko Makela.
  Early community documentation of undocumented 6502/6510 opcodes; basis for
  the VICE mnemonic convention used by mist64/c64ref.

These documents are widely redistributed in the C64 community and carry no
formal license; they are referenced as established factual sources.

## Commodore 64 Programmer's Reference Guide

- Publisher: Commodore Business Machines, Inc.
- Year: 1982
- Copyright: Commodore Business Machines, Inc.

The `basic/` domain pages (`keywords.md`, `functions.md`, `errors.md`,
`program-structure.md`, `variables.md`, `io.md`, `graphics-sound.md`,
`machine-code-bridge.md`, `examples.md`) contain AI-first summaries derived
from this manual covering BASIC V2 language semantics, syntax, error
conditions, variable rules, file I/O concepts, and runnable program shapes.
No verbatim text is reproduced. The manual is out of print and widely
available as a public reference document in the C64 community.

## Original hardware and format manuals

The following pages summarize factual interface contracts from original
manuals or maintained format specifications. No manual text or listings are
reproduced:

- **Commodore 1351 Mouse User's Manual** — Commodore Business Machines, Inc.,
  1986; used by `io/mouse-1351.md`.
- **Passport MIDI Interface User's Manual** — Passport Designs, Inc.; used by
  `io/midi.md` for the Passport/Syntech hardware map.
- **Commodore VIC-1541 Floppy Drive User's Manual** — Commodore Business
  Machines, Inc.; used by `io/fast-loaders.md` for drive and serial-bus
  architecture.
- **SID File Format Description** — HVSC format documentation by Michael
  Schwendt, Simon White, Dag Lem, Wilfred Bos, and LaLa; used by
  `music/sid-file-format.md`.

Exact archive locations and local consumers are listed in
`sources/INDEX.md` under `primary-manuals`.

## Assembler documentation

The `asm/` domain pages cite each assembler's own documentation as their
upstream source. No code or text is copied from these projects; pages contain
AI-first syntax summaries. Respective upstream sources:

- **ACME** — Marco Baye; https://sourceforge.net/projects/acme-crossass/
- **KickAssembler** — Mads Nielsen; http://theweb.dk/KickAssembler/
- **CA65 / cc65** — cc65 contributors; https://cc65.github.io/ (zlib license)
- **64tass** — Soci/Singular; https://sourceforge.net/projects/tass64/

## Codebase64 Wiki

- Site: https://codebase64.net/
- License: CC Attribution-NonCommercial-Share Alike 4.0 International
  (https://creativecommons.org/licenses/by-nc-sa/4.0/)
- Contributors: community-authored wiki

Pages in this repository that extract or summarize content from Codebase64
carry the same CC BY-NC-SA 4.0 license as the source. Each such page notes
the origin in its `## sources` section. No verbatim text is reproduced;
content is distilled into compact tables and bullets per AGENTS.md rules.

The `sprites/advanced.md` hub and linked effect/display-mode pages surface
Codebase64-derived sprite techniques such as DYSP, sprite multiplexers,
open-border interactions, starfields, and sprite-underlay display modes via
their cited local summaries.

## Toolchain documentation

The `toolchains/` domain pages cite each tool's own documentation as their
upstream source. No code or text is copied from these projects; pages contain
AI-first workflow summaries. Respective upstream sources:

- **VICE** — VICE team; https://vice-emu.sourceforge.io/ (GPL-2.0).
  Workflow and CLI conventions in `toolchains/vice.md` are derived from the
  VICE manual (`vice.pdf`) distributed with each release.
- **ACME workflow** — see ACME entry above; CLI behavior in
  `toolchains/acme-workflow.md` is derived from the ACME user manual.
- **KickAssembler workflow** — see KickAssembler entry above; CLI behavior
  in `toolchains/kickassembler-workflow.md` is derived from the
  KickAssembler reference manual.
- **CA65 workflow** — see CA65 / cc65 entry above; `ca65`/`ld65` CLI behavior
  in `toolchains/ca65-workflow.md` is derived from `ca65.html` and `ld65.html`
  in the cc65 documentation.
- **64tass workflow** — see 64tass entry above; CLI behavior in
  `toolchains/64tass-workflow.md` is derived from the 64tass manual.
- **CBM prg Studio** — Arthur Jordison; https://www.ajordison.co.uk/.
  Project / IDE conventions in `toolchains/cbm-studio.md` are derived from
  the CBM prg Studio documentation distributed with the installer.
