---
type: reference
domain: toolchains
granularity: emulator
summary: "Run and debug a prg in VICE: autostart, monitor, command-line flags."
keywords: [VICE, emulator workflow, autostart, monitor, debugging]
---

## facts
- VICE (Versatile Commodore Emulator) is the reference C64 emulator on Windows, macOS, and Linux.
- The C64 binary is `x64sc` (cycle-exact, preferred) or `x64` (faster, less accurate).
- VICE accepts `.prg`, `.d64`, `.t64`, `.tap`, and `.crt` images as positional command-line arguments.
- A `.prg` argument is autostarted: VICE loads it and issues `RUN` automatically.
- Built-in monitor is opened with `Alt+M` (Windows/Linux) or `Cmd+H` (macOS), or with `-moncommands <file>` on launch.
- Target version: VICE 3.7 or later.

## sequence
### Autostart a `.prg`
1. Build a `.prg` with a 2-byte load-address header (see [../asm/common-patterns.md](../asm/common-patterns.md)).
2. Launch: `x64sc out.prg`.
3. VICE attaches the file as a virtual tape/disk and issues `RUN` once BASIC is ready.
4. For a BASIC SYS stub at `$0801`, `RUN` enters machine code at the `SYS` target.

### Manual load (no autostart)
1. Launch `x64sc` with no positional argument.
2. From the Commodore screen: `LOAD "OUT.PRG",8,1` (absolute-load to embedded address).
3. Type `SYS <addr>` for `.prg` files whose load address is not `$0801`.

### Debugging with the monitor
1. Open the monitor (`Alt+M` / `Cmd+H`).
2. Common commands: `g <addr>` (go), `z` (step), `n` (next), `bk <addr>` (breakpoint), `m <addr>` (memory), `d <addr>` (disassemble), `r` (registers).
3. Resume with `x` (exit monitor) or `g`.

## lookup
| need | flag / command | notes |
|---|---|---|
| Autostart a file | positional arg | `x64sc out.prg` |
| Force PAL/NTSC | `-pal` / `-ntsc` | Default is platform-dependent. |
| Warp mode (no throttle) | `-warp` | Faster builds-and-test. |
| Headless / batch testing | `-console` (no GUI), `-limitcycles N` | Useful for CI. |
| Issue monitor commands at start | `-moncommands <file>` | File holds one command per line. |
| JAM trap (illegal opcode) | `-monitor` | Drops to monitor on JAM. |
| Record screen / video | `-recordvideo` | Format depends on FFmpeg support. |
| Snapshot save/load | `-initbreak`, F10/F11 | Bind keys via settings. |
| Attach disk image | `-8 image.d64` | Drive 8 default. |
| Reset machine | monitor `reset` / `Alt+R` | Hard / soft reset. |

## constraints
- `x64` and `x64sc` differ in cycle accuracy; raster-effect or sprite/badline-sensitive code SHOULD be tested under `x64sc`.
- Autostart only triggers when the positional argument is a single program/image; multiple files require manual `LOAD`.
- A `.prg` load address outside `$0801` autostarts to its address only if the program is self-launching; otherwise the user MUST `SYS <addr>` after load.
- Monitor breakpoints survive across reset but not across emulator restart; use `-moncommands` to script them.
- VICE's exact behavior (kernel revision, keymaps, drive emulation) is outside the local source corpus and MUST be cited from the VICE manual when contested.

## examples
Launch a freshly built program in warp mode for fast iteration:
```
x64sc -warp -pal out.prg
```

Launch with monitor commands scripted at start:
```
x64sc -moncommands debug.txt out.prg
```
where `debug.txt` contains:
```
bk $080d
g
```

## links
- common patterns: [../asm/common-patterns.md](../asm/common-patterns.md)
- program entrypoints: [../tasks/program-entrypoints.md](../tasks/program-entrypoints.md)
- ACME workflow: [acme-workflow.md](acme-workflow.md)
- KickAssembler workflow: [kickassembler-workflow.md](kickassembler-workflow.md)
- CA65 workflow: [ca65-workflow.md](ca65-workflow.md)
- 64tass workflow: [64tass-workflow.md](64tass-workflow.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- attribution: [../ATTRIBUTION.md](../ATTRIBUTION.md)
- upstream: VICE manual (https://vice-emu.sourceforge.io/), `vice.pdf` distributed with each release.
