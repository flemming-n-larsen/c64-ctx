---
type: reference
domain: tools
granularity: crunchers
---

## facts
- Crunchers compress a `.prg` binary; an integrated or separate decruncher decompresses it at load time on the C64.
- The speed/ratio tradeoff: ByteBoozer (fastest, ok ratio) → Pucrunch (fast, good ratio) → Exomizer (slower, best ratio).
- Pucrunch may produce corrupt output on very small binaries.
- ByteBoozer's cross version ships with an integrated C64 decruncher+loader, making it common in demo final-part releases.

## lookup — cross-platform crunchers
| tool | author | notes |
|---|---|---|
| Exomizer | Mageli | Slower compression; best results; widely used for final releases. |
| Pucrunch | Pasi "Albert" Ojala | Fast; good results; may bug on very small binaries. |
| ByteBoozer (cross) | HCL | Fast; ok results; integrated decruncher+loader; demo-oriented. |

## lookup — native crunchers (run on C64)
| tool | author | CSDB ID |
|---|---|---|
| ByteBoozer 1.0 | HCL | 15274 |
| 2MHz Time Cruncher V5.0 | Stoat + Tim | 30939 |
| The Cruncher AB V1.0 | Zizyphus, Skyflash/Oneway; bugfix Crossbow/Crest | 48475 |
| Byte Boiler V1.0 | Zizyphus, Skyflash/OneWay | 51249 |

## constraints
- Decruncher code must fit in memory alongside the payload; account for its load address and size when planning the memory map.
- Crunched data is not executable; a stub or BASIC loader must decompress to the target address before `SYS`.
- Some crunchers alter load address or introduce a self-decompressing header; verify final load address before linking.

## links
- memory map: [../memory/INDEX.md](../memory/INDEX.md)
- optimization context: [../optimization/INDEX.md](../optimization/INDEX.md)
- transfer to hardware: [transfer.md](transfer.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- Exomizer: https://bitbucket.org/magli143/exomizer/wiki/Home
- Pucrunch: http://www.cs.tut.fi/~albert/Dev/pucrunch/
- ByteBoozer (cross): https://csdb.dk/release/?id=33093
- ByteBoozer 1.0 (native): https://csdb.dk/release/?id=15274
- 2MHz Time Cruncher V5.0: https://csdb.dk/release/?id=30939
- The Cruncher AB V1.0: https://csdb.dk/release/?id=48475
- Byte Boiler V1.0: https://csdb.dk/release/?id=51249
- codebase64.net tools page: https://codebase64.net/doku.php?id=tools:start (CC BY-NC-SA 4.0)
