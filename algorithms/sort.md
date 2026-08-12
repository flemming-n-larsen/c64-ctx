---
type: reference
domain: algorithms
granularity: atomic
summary: "Bubble, shell and quicksort for 8- and 16-bit arrays in RAM."
keywords: [sorting, bubble sort, shell sort, quicksort, sprite Y sort]
---

## facts
- Sorting on the 6502 operates entirely in RAM; typical inputs are arrays of 8-bit or 16-bit values (sprite Y coordinates, scores, keys).
- Bubble sort is simplest: O(n²) worst case, ~5–10 bytes code; suitable for n ≤ 16.
- Shell sort is O(n log² n) average; fewer swaps than bubble sort for larger arrays.
- Quicksort is O(n log n) average but requires a call stack; avoid for very small n or constrained stack space.
- Combination sort (shell + insertion hybrid) often outperforms both bubble and pure shell sort in practice.
- Insertion sort by Y coordinate is used in sprite multiplexing (see [../effects/sprite-multiplexer.md](../effects/sprite-multiplexer.md)).

## lookup
| algorithm | best | average | worst | space | swap cost | notes |
|---|---|---|---|---|---|---|
| Bubble sort 8-bit | O(n) | O(n²) | O(n²) | O(1) | 3 cycles | Stop early on no-swap pass |
| Bubble sort 16-bit | O(n) | O(n²) | O(n²) | O(1) | 6 cycles | Compare high then low |
| Combination sort 8-bit | O(n log n) | O(n log n) | O(n²) | O(1) | — | Shell-sort gap sequence |
| Optimal sort 8-bit | O(n log n) | O(n log n) | O(n log n) | O(1) | — | Best for n ≤ 256 |
| Shell sort 16-bit | O(n log² n) | O(n log² n) | O(n²) | O(1) | — | Good for n ≤ 256 |
| Quicksort 16-bit | O(n log n) | O(n log n) | O(n²) | O(log n) | — | Requires stack; recursive |

## sequence
Bubble sort 8-bit (array at `arr`, length in `len`):
```
outer:
    LDX #0           ; swap flag
    LDY #0
inner:
    LDA arr,Y
    CMP arr+1,Y
    BCC no_swap
    PHA
    LDA arr+1,Y
    STA arr,Y
    PLA
    STA arr+1,Y
    INX              ; mark swap occurred
no_swap:
    INY
    CPY len_minus_1
    BNE inner
    TXA
    BNE outer        ; repeat if any swap
    RTS
```

Shell sort gap sequence (Knuth: 1, 4, 13, 40, 121...):
```
; Use decreasing gaps: start at largest gap ≤ n, halve each pass
gaps: .byte 121, 40, 13, 4, 1
```

## constraints
- Bubble sort MUST track whether any swap occurred in a pass; stopping early on a sorted array gives O(n) best case.
- Quicksort recursion depth can reach O(n) worst case on sorted input; use median-of-three pivot or shuffle first if input may be pre-sorted.
- 16-bit sort MUST compare high bytes first; swap both bytes atomically (no IRQ between the two STA instructions for interrupt-sensitive arrays).
- For sprite Y sorting specifically, insertion sort is preferred for counts ≤ 8 — see [../effects/sprite-multiplexer.md](../effects/sprite-multiplexer.md).

## sources

- codebase64.net: [Bubble sort 8-bit elements](https://codebase64.net/doku.php?id=base:bubble_sort_8-bit_elements) — CC BY-NC-SA 4.0
- codebase64.net: [Bubble sort 16-bit elements](https://codebase64.net/doku.php?id=base:bubble_sort_16-bit_elements) — CC BY-NC-SA 4.0
- codebase64.net: [Combination sort 8-bit elements](https://codebase64.net/doku.php?id=base:combination_sort_8-bit_elements) — CC BY-NC-SA 4.0
- codebase64.net: [Optimal sort 8-bit elements](https://codebase64.net/doku.php?id=base:optimal_sort_8-bit_elements) — CC BY-NC-SA 4.0
- codebase64.net: [Optimal sort 16-bit elements](https://codebase64.net/doku.php?id=base:optimal_sort_16-bit_elements) — CC BY-NC-SA 4.0
- codebase64.net: [Shell sort 16-bit elements](https://codebase64.net/doku.php?id=base:shell_sort_16-bit_elements) — CC BY-NC-SA 4.0
- codebase64.net: [Quicksort 16-bit elements](https://codebase64.net/doku.php?id=base:quicksort_16-bit_elements) — CC BY-NC-SA 4.0
- effects: [../effects/sprite-multiplexer.md](../effects/sprite-multiplexer.md)
- algorithms: [rng.md](rng.md)
