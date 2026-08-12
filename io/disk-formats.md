---
type: reference
domain: io
granularity: reference
summary: "D64, D71 and D81 image layout: tracks, sectors, BAM, and directory entries."
keywords: [D64, D71, D81, disk image, BAM, directory entry, track sector]
---

## facts
- D64, D71, and D81 are flat binary images of Commodore disk media; each byte in the image corresponds to one byte on the physical disk.
- All three formats use 256-byte sectors linked by a 2-byte chain header at offset 0 (next track) and offset 1 (next sector); a chain-end sector stores `$00` at offset 0.
- Track numbers are 1-based; sector numbers are 0-based.
- D64 images 1541 single-sided DD disks; D71 images 1571 double-sided DD disks; D81 images 1581 3.5″ DD disks.

## lookup — D64 (1541)
| property | value |
|---|---|
| Tracks | 35 (expandable to 40 in some tools) |
| Sectors by zone | Tracks 1–17: 21 sec; 18–24: 19 sec; 25–30: 18 sec; 31–35: 17 sec |
| Total sectors | 683 |
| Image size | 174,848 bytes (no error block); 175,531 bytes (with 683-byte error block appended) |
| Directory track | 18 |
| BAM sector | Track 18, sector 0 |
| First directory sector | Track 18, sector 1 |

## lookup — D71 (1571)
| property | value |
|---|---|
| Tracks | 70 (35 per side; side 2 = tracks 36–70) |
| Sector counts | Side 2 mirrors side 1 zone counts (tracks 36–52: 21 sec; etc.) |
| Total sectors | 1,366 |
| Image size | 349,696 bytes |
| Directory track | 18 |
| BAM sectors | Track 18, sector 0 (side 1); track 53, sector 0 (side 2) |

## lookup — D81 (1581)
| property | value |
|---|---|
| Tracks | 80 |
| Sectors per track | 40 (uniform) |
| Total sectors | 3,200 |
| Image size | 819,200 bytes |
| Directory track | 40 |
| BAM sectors | Track 40, sectors 1 and 2 |

## lookup — BAM entry (D64, per track, starting at track 18/0 offset $04)
| bytes | content |
|---|---|
| 1 byte | Free sector count for this track |
| 3 bytes | Sector allocation bitmap (bit N = sector N free if set) |

## lookup — directory entry (32 bytes each, 8 per sector)
| offset | bytes | content |
|---|---|---|
| `$00` | 2 | Track/sector of next directory sector (first entry only; `$00/$00` elsewhere) |
| `$02` | 1 | File type: `$81` = PRG, `$82` = SEQ, `$83` = USR, `$84` = REL; `$80` OR'd = closed |
| `$03` | 2 | Start track/sector of file |
| `$05` | 16 | Filename padded with `$A0` |
| `$15` | 2 | REL side-sector track/sector (non-REL files: ignored) |
| `$17` | 1 | REL record length |
| `$1C` | 2 | File size in 254-byte blocks (little-endian) |

## constraints
- Sector offset 0–1 are always the chain link; file data begins at offset `$02` in each sector, giving 254 usable bytes per sector.
- The BAM at track 18/0 stores the disk name at offset `$90` (16 bytes) and the disk ID at `$A2` (2 bytes).
- D71 BAM uses a side-2 extension: free-count bytes for tracks 36–70 are packed at offset `$DD` in track 18/0.
- The error block appended to a D64 (if present) contains one byte per sector: `$01` = no error, other values = specific 1541 error codes.
- KERNAL file I/O does not expose format structure; format knowledge is needed only for disk image tools, copiers, or custom DOS replacements.

## sources

- attribution: [../ATTRIBUTION.md](../ATTRIBUTION.md)
- upstream: VICE emulator source (src/diskimage/), D64 format spec (Peter Schepers / www.unusedino.de/ec64/), c64-wiki.com (GFDL).
- disk and tape I/O overview: [disk-tape-io.md](disk-tape-io.md)
- KERNAL file I/O calls: [../kernal/file-io.md](../kernal/file-io.md)
- load/save recipe: [../tasks/load-save-file.md](../tasks/load-save-file.md)
