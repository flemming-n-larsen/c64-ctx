---
type: reference
domain: algorithms
granularity: atomic
---

## facts
- C64 compression is used to pack `.prg` files, disk sectors, and in-memory data; decompression runs at load time or from RAM.
- RLE (Run-Length Encoding) is the simplest: repeat a byte N times, or flag literal runs; fast to decompress (~5 cycles/byte).
- LZW (Lempel-Ziv-Welch) builds a dictionary of repeated sequences; better ratio than RLE, more complex decoder.
- LZ77-family (including LZMPI) uses a sliding window; excellent ratio, slower decompress; commonly used by demo packers.
- Dictionary compression matches fixed or adaptive dictionary entries; good for structured data (charsets, sprites).
- Compression benchmarks show ratio vs. decruncher speed trade-offs; RLE is fastest to decompress, LZ77 gives best ratios.

## lookup
| algorithm | ratio | decompress speed | encoder complexity | notes |
|---|---|---|---|---|
| RLE | low–moderate | very fast (~5 cyc/byte) | trivial | Best for highly repetitive data |
| LZW | moderate | moderate | moderate | Dictionary grows during compression |
| LZ77 / LZMPI | high | slow–moderate | high | Best ratio; used by demo packers |
| MDG Bytesmasher | high | moderate | high | Popular C64-specific packer |
| Dictionary (fixed) | moderate | fast | low–moderate | Good for charset/sprite data |

RLE packet format (common variant):
| byte | meaning |
|---|---|
| $00 | escape: next two bytes = (count, value) |
| other | literal byte, copy as-is |

LZ77 match format (conceptual):
| field | description |
|---|---|
| offset | distance back in sliding window |
| length | number of bytes to copy |
| literal | byte that didn't match (emit raw) |

## sequence
RLE decompression (input stream → output buffer):
```
rle_decode:
    LDA (src),Y     ; read next byte
    INY
    CMP #$00        ; escape marker?
    BNE literal
    ; repeat: fetch count then value
    LDA (src),Y     ; count
    INY
    TAX
    LDA (src),Y     ; value
    INY
rep_loop:
    STA (dst),Y
    ; (adjust dst pointer)
    DEX
    BNE rep_loop
    JMP rle_decode
literal:
    STA (dst),Y
    ; (adjust dst pointer)
    JMP rle_decode
```

## constraints
- RLE encoding MUST choose an escape byte that does not appear frequently in uncompressed data; a poor escape byte can expand the data.
- LZ77 decompressor MUST handle overlapping copies (source and destination overlap in the sliding window); copy byte-by-byte, not block-copy.
- LZMPI and MDG packers have specific header formats; decompression code is packer-specific and MUST match the encoder version exactly.
- Decompressor MUST be placed in RAM before execution; if compressed data overwrites the decompressor itself, decompress backwards or use a two-pass approach.
- In-place decompression (compressed data expands into the same region) requires that the compressed data is placed at the end of the target area and decompression runs backwards.

## links
- algorithms: [rng.md](rng.md)
- memory: [../memory/INDEX.md](../memory/INDEX.md)

## sources
- codebase64.net: [RLE pack/unpack](https://codebase64.net/doku.php?id=base:rle_pack_unpack) — CC BY-NC-SA 4.0
- codebase64.net: [The secret of fast LZW crunching](https://codebase64.net/doku.php?id=base:the_secret_of_fast_lzw_crunching) — CC BY-NC-SA 4.0
- codebase64.net: [LZMPI compression](https://codebase64.net/doku.php?id=base:lzmpi_compression) — CC BY-NC-SA 4.0
- codebase64.net: [MDG Bytesmasher 0.04](https://codebase64.net/doku.php?id=base:mdg_bytesmasher_0.04) — CC BY-NC-SA 4.0
- codebase64.net: [Dictionary compression](https://codebase64.net/doku.php?id=base:dictionary_compression) — CC BY-NC-SA 4.0
- codebase64.net: [Compression benchmarks](https://codebase64.net/doku.php?id=base:compression_benchmarks) — CC BY-NC-SA 4.0
- provenance: [../sources/INDEX.md](../sources/INDEX.md)
