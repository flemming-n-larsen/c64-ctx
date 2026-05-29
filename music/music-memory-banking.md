---
type: reference
domain: music
granularity: atomic
---

## facts
- Music data/code should ideally avoid the I/O window `$D000-$DFFF`, because that range normally exposes SID, VIC-II, CIA, and expansion registers instead of RAM.
- Setting `$01 = $35` is not enough to expose RAM under `$D000-$DFFF`; Codebase64 notes you need `$01 = $30` (or another value with the low four bits clear) to reveal full RAM there.
- Once I/O is hidden, direct `STA $D400`-style writes from a music player will hit RAM instead of the SID, so ordinary players go silent unless you add a workaround.
- The recommended workaround is `ghost registers`: write SID-shadow values to RAM (for example `$4000-$4018`) while I/O is hidden, then copy those bytes to `$D400-$D418` after re-enabling I/O.

## ghost-register pattern
```asm
LDA #$30
STA $01
JSR $D003          ; player writes shadow/ghost registers instead of SID I/O

LDA #$37
STA $01

LDX #$18
LDA $4000,X
  STA $D400,X
  DEX
  BPL -
```

## constraints
- Hiding I/O also hides the live SID registers, so any player that still writes to `$D400-$D418` directly will fail while `$01 = $30` is active.
- Tune data that overlaps `$D400-$D418` is especially dangerous because hidden-I/O writes can corrupt both music data and intended SID output behavior.
- Newer trackers/editors may support ghost-register output directly; older players often require manual patching.

## links
- tune integration: [tune-integration.md](tune-integration.md)
- IRQ music player: [irq-music-player.md](irq-music-player.md)
- SID registers: [../sid/registers.md](../sid/registers.md)
- processor port / `$01`: [../io/processor-port.md](../io/processor-port.md)
- I/O area memory: [../memory/io-area.md](../memory/io-area.md)
- music index: [INDEX.md](INDEX.md)

## sources
- codebase64.net: [Avoiding the `$D000-$DFFF` issue for playing music](https://codebase64.net/doku.php?id=base:avoiding_the_d000-_dfff_issue_for_playing_music) — CC BY-NC-SA 4.0
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
