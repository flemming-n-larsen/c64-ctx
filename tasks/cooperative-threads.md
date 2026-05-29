---
type: reference
domain: tasks
source: codebase64.net
---

## facts
- Cooperative multitasking on 6502 uses the hardware stack (`$0100–$01FF`) split between threads.
- Each thread's context is its stack slice; switching = swap the stack pointer register (S).
- The IRQ handler performs context switches in round-robin order.
- Each thread's stack holds: Y, X, A (pushed), then Status and PC (pushed by IRQ).
- NMI can be used instead of IRQ to leave the standard IRQ channel free.

## sequence

### Initialization — split stack and launch two threads
```asm
num_threads = 2
thread_data .byte 0, 0   ; saved S values per thread
thread_num  .byte 0

    ; Thread 1 is already running; carve off space for Thread 2
    tsx
    txa
    tay
    sec
    sbc #$20             ; Thread 2 gets $20 stack bytes
    tax
    txs

    ; Pre-load Thread 2's initial register state onto its stack
    lda #>thread2
    pha                  ; PC high
    lda #<thread2
    pha                  ; PC low
    lda #0
    pha                  ; Status
    pha                  ; A
    pha                  ; X
    pha                  ; Y

    ; Save Thread 2's stack pointer
    tsx
    txa
    sta thread_data+1

    ; Restore Thread 1's stack pointer
    tya
    tax
    txs
```

### Context switch handler (called from IRQ)
```asm
context_switch
    ldy thread_num
    tsx
    txa
    sta thread_data,y    ; save current S

    iny
    cpy #num_threads
    bne no_wrap
    ldy #0
no_wrap
    sty thread_num

    lda thread_data,y
    tax
    txs                  ; restore next thread's S

    jmp $EA31            ; KERNAL IRQ exit (with KERNAL enabled)
```

### Thread bodies (example)
```asm
thread1
    inc $D020            ; toggle border
    ldy #$01
    jsr wait
    jmp thread1

thread2
    lda #<msg
    ldy #>msg
    jsr $AB1E            ; KERNAL print
    ldy #0
    jsr wait
    jmp thread2
```

## constraints
- Stack is only 256 bytes; with 2 threads each gets ~128 bytes. Deep call stacks risk collision.
- If more threads or deeper stacks are needed, save/restore the entire `$0100–$01FF` area per switch (expensive).
- Threads must voluntarily yield (cooperative); a tight infinite loop without a yield will starve others.
- NMI version: replace `JMP $EA31` with `RTI` and install handler at `$FFFA/$FFFB`.
- All threads share the same zero page, memory, and I/O registers — no isolation.

## links
- raster interrupt setup: [raster-interrupt.md](raster-interrupt.md)
- game loop pattern: [game-loop.md](game-loop.md)
- bank switch (KERNAL on/off): [bank-switch-rom-ram.md](bank-switch-rom-ram.md)

## sources
- https://codebase64.net/doku.php?id=base:threads_on_the_6502 — CC BY-NC-SA 4.0
- [../sources/INDEX.md](../sources/INDEX.md)
