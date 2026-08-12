---
type: reference
domain: charset
granularity: atomic
summary: "Glyph bytes for the alternate (lowercase) character ROM set, 8 bytes per screen code."
keywords: [chargen ROM, lowercase set, glyph bytes, character bitmaps]
---

## facts
- Alternate character set occupies ROM bytes `$1000-$17FF` (screen codes `$00-$7F`) and `$1800-$1FFF` (screen codes `$80-$FF`).
- Each character is 8 bytes; each byte is one 8-pixel row, MSB = leftmost pixel, set bit = foreground.
- Screen codes `$80-$FF` are bitwise-NOT of `$00-$7F` with one ROM exception: screen code `$80` byte 5 is `$99` not `$9D`.
- Alternate set shows lowercase letters; activated by SHIFT+CBM or VIC-II `$D018` character base offset `$1000`.
- `sc` = screen code (ROM index); `ic` = interchange (PETSCII printable) code.

## lookup
| sc | ic | name | bytes |
|---:|---:|---|---|
| `$00` | `$40` | COMMERCIAL AT | `3C 66 6E 6E 60 62 3C 00` |
| `$01` | `$41` | LATIN SMALL LETTER A | `00 00 3C 06 3E 66 3E 00` |
| `$02` | `$42` | LATIN SMALL LETTER B | `00 60 60 7C 66 66 7C 00` |
| `$03` | `$43` | LATIN SMALL LETTER C | `00 00 3C 60 60 60 3C 00` |
| `$04` | `$44` | LATIN SMALL LETTER D | `00 06 06 3E 66 66 3E 00` |
| `$05` | `$45` | LATIN SMALL LETTER E | `00 00 3C 66 7E 60 3C 00` |
| `$06` | `$46` | LATIN SMALL LETTER F | `00 0E 18 3E 18 18 18 00` |
| `$07` | `$47` | LATIN SMALL LETTER G | `00 00 3E 66 66 3E 06 7C` |
| `$08` | `$48` | LATIN SMALL LETTER H | `00 60 60 7C 66 66 66 00` |
| `$09` | `$49` | LATIN SMALL LETTER I | `00 18 00 38 18 18 3C 00` |
| `$0A` | `$4A` | LATIN SMALL LETTER J | `00 06 00 06 06 06 06 3C` |
| `$0B` | `$4B` | LATIN SMALL LETTER K | `00 60 60 6C 78 6C 66 00` |
| `$0C` | `$4C` | LATIN SMALL LETTER L | `00 38 18 18 18 18 3C 00` |
| `$0D` | `$4D` | LATIN SMALL LETTER M | `00 00 66 7F 7F 6B 63 00` |
| `$0E` | `$4E` | LATIN SMALL LETTER N | `00 00 7C 66 66 66 66 00` |
| `$0F` | `$4F` | LATIN SMALL LETTER O | `00 00 3C 66 66 66 3C 00` |
| `$10` | `$50` | LATIN SMALL LETTER P | `00 00 7C 66 66 7C 60 60` |
| `$11` | `$51` | LATIN SMALL LETTER Q | `00 00 3E 66 66 3E 06 06` |
| `$12` | `$52` | LATIN SMALL LETTER R | `00 00 7C 66 60 60 60 00` |
| `$13` | `$53` | LATIN SMALL LETTER S | `00 00 3E 60 3C 06 7C 00` |
| `$14` | `$54` | LATIN SMALL LETTER T | `00 18 7E 18 18 18 0E 00` |
| `$15` | `$55` | LATIN SMALL LETTER U | `00 00 66 66 66 66 3E 00` |
| `$16` | `$56` | LATIN SMALL LETTER V | `00 00 66 66 66 3C 18 00` |
| `$17` | `$57` | LATIN SMALL LETTER W | `00 00 63 6B 7F 3E 36 00` |
| `$18` | `$58` | LATIN SMALL LETTER X | `00 00 66 3C 18 3C 66 00` |
| `$19` | `$59` | LATIN SMALL LETTER Y | `00 00 66 66 66 3E 0C 78` |
| `$1A` | `$5A` | LATIN SMALL LETTER Z | `00 00 7E 0C 18 30 7E 00` |
| `$1B` | `$5B` | LEFT SQUARE BRACKET | `3C 30 30 30 30 30 3C 00` |
| `$1C` | `$5C` | POUND SIGN | `0C 12 30 7C 30 62 FC 00` |
| `$1D` | `$5D` | RIGHT SQUARE BRACKET | `3C 0C 0C 0C 0C 0C 3C 00` |
| `$1E` | `$5E` | UPWARDS ARROW | `00 18 3C 7E 18 18 18 18` |
| `$1F` | `$5F` | LEFTWARDS ARROW | `00 10 30 7F 7F 30 10 00` |
| `$20` | `$20` | SPACE | `00 00 00 00 00 00 00 00` |
| `$21` | `$21` | EXCLAMATION MARK | `18 18 18 18 00 00 18 00` |
| `$22` | `$22` | QUOTATION MARK | `66 66 66 00 00 00 00 00` |
| `$23` | `$23` | NUMBER SIGN | `66 66 FF 66 FF 66 66 00` |
| `$24` | `$24` | DOLLAR SIGN | `18 3E 60 3C 06 7C 18 00` |
| `$25` | `$25` | PERCENT SIGN | `62 66 0C 18 30 66 46 00` |
| `$26` | `$26` | AMPERSAND | `3C 66 3C 38 67 66 3F 00` |
| `$27` | `$27` | APOSTROPHE | `06 0C 18 00 00 00 00 00` |
| `$28` | `$28` | LEFT PARENTHESIS | `0C 18 30 30 30 18 0C 00` |
| `$29` | `$29` | RIGHT PARENTHESIS | `30 18 0C 0C 0C 18 30 00` |
| `$2A` | `$2A` | ASTERISK | `00 66 3C FF 3C 66 00 00` |
| `$2B` | `$2B` | PLUS SIGN | `00 18 18 7E 18 18 00 00` |
| `$2C` | `$2C` | COMMA | `00 00 00 00 00 18 18 30` |
| `$2D` | `$2D` | HYPHEN-MINUS | `00 00 00 7E 00 00 00 00` |
| `$2E` | `$2E` | FULL STOP | `00 00 00 00 00 18 18 00` |
| `$2F` | `$2F` | SOLIDUS | `00 03 06 0C 18 30 60 00` |
| `$30` | `$30` | DIGIT ZERO | `3C 66 6E 76 66 66 3C 00` |
| `$31` | `$31` | DIGIT ONE | `18 18 38 18 18 18 7E 00` |
| `$32` | `$32` | DIGIT TWO | `3C 66 06 0C 30 60 7E 00` |
| `$33` | `$33` | DIGIT THREE | `3C 66 06 1C 06 66 3C 00` |
| `$34` | `$34` | DIGIT FOUR | `06 0E 1E 66 7F 06 06 00` |
| `$35` | `$35` | DIGIT FIVE | `7E 60 7C 06 06 66 3C 00` |
| `$36` | `$36` | DIGIT SIX | `3C 66 60 7C 66 66 3C 00` |
| `$37` | `$37` | DIGIT SEVEN | `7E 66 0C 18 18 18 18 00` |
| `$38` | `$38` | DIGIT EIGHT | `3C 66 66 3C 66 66 3C 00` |
| `$39` | `$39` | DIGIT NINE | `3C 66 66 3E 06 66 3C 00` |
| `$3A` | `$3A` | COLON | `00 00 18 00 00 18 00 00` |
| `$3B` | `$3B` | SEMICOLON | `00 00 18 00 00 18 18 30` |
| `$3C` | `$3C` | LESS-THAN SIGN | `0E 18 30 60 30 18 0E 00` |
| `$3D` | `$3D` | EQUALS SIGN | `00 00 7E 00 7E 00 00 00` |
| `$3E` | `$3E` | GREATER-THAN SIGN | `70 18 0C 06 0C 18 70 00` |
| `$3F` | `$3F` | QUESTION MARK | `3C 66 06 0C 18 00 18 00` |
| `$40` | `$C0` | BOX DRAWINGS LIGHT HORIZONTAL | `00 00 00 FF FF 00 00 00` |
| `$41` | `$C1` | LATIN CAPITAL LETTER A | `18 3C 66 7E 66 66 66 00` |
| `$42` | `$C2` | LATIN CAPITAL LETTER B | `7C 66 66 7C 66 66 7C 00` |
| `$43` | `$C3` | LATIN CAPITAL LETTER C | `3C 66 60 60 60 66 3C 00` |
| `$44` | `$C4` | LATIN CAPITAL LETTER D | `78 6C 66 66 66 6C 78 00` |
| `$45` | `$C5` | LATIN CAPITAL LETTER E | `7E 60 60 78 60 60 7E 00` |
| `$46` | `$C6` | LATIN CAPITAL LETTER F | `7E 60 60 78 60 60 60 00` |
| `$47` | `$C7` | LATIN CAPITAL LETTER G | `3C 66 60 6E 66 66 3C 00` |
| `$48` | `$C8` | LATIN CAPITAL LETTER H | `66 66 66 7E 66 66 66 00` |
| `$49` | `$C9` | LATIN CAPITAL LETTER I | `3C 18 18 18 18 18 3C 00` |
| `$4A` | `$CA` | LATIN CAPITAL LETTER J | `1E 0C 0C 0C 0C 6C 38 00` |
| `$4B` | `$CB` | LATIN CAPITAL LETTER K | `66 6C 78 70 78 6C 66 00` |
| `$4C` | `$CC` | LATIN CAPITAL LETTER L | `60 60 60 60 60 60 7E 00` |
| `$4D` | `$CD` | LATIN CAPITAL LETTER M | `63 77 7F 6B 63 63 63 00` |
| `$4E` | `$CE` | LATIN CAPITAL LETTER N | `66 76 7E 7E 6E 66 66 00` |
| `$4F` | `$CF` | LATIN CAPITAL LETTER O | `3C 66 66 66 66 66 3C 00` |
| `$50` | `$D0` | LATIN CAPITAL LETTER P | `7C 66 66 7C 60 60 60 00` |
| `$51` | `$D1` | LATIN CAPITAL LETTER Q | `3C 66 66 66 66 3C 0E 00` |
| `$52` | `$D2` | LATIN CAPITAL LETTER R | `7C 66 66 7C 78 6C 66 00` |
| `$53` | `$D3` | LATIN CAPITAL LETTER S | `3C 66 60 3C 06 66 3C 00` |
| `$54` | `$D4` | LATIN CAPITAL LETTER T | `7E 18 18 18 18 18 18 00` |
| `$55` | `$D5` | LATIN CAPITAL LETTER U | `66 66 66 66 66 66 3C 00` |
| `$56` | `$D6` | LATIN CAPITAL LETTER V | `66 66 66 66 66 3C 18 00` |
| `$57` | `$D7` | LATIN CAPITAL LETTER W | `63 63 63 6B 7F 77 63 00` |
| `$58` | `$D8` | LATIN CAPITAL LETTER X | `66 66 3C 18 3C 66 66 00` |
| `$59` | `$D9` | LATIN CAPITAL LETTER Y | `66 66 66 3C 18 18 18 00` |
| `$5A` | `$DA` | LATIN CAPITAL LETTER Z | `7E 06 0C 18 30 60 7E 00` |
| `$5B` | `$DB` | BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL | `18 18 18 FF FF 18 18 18` |
| `$5C` | `$DC` | LEFT HALF MEDIUM SHADE | `C0 C0 30 30 C0 C0 30 30` |
| `$5D` | `$DD` | BOX DRAWINGS LIGHT VERTICAL | `18 18 18 18 18 18 18 18` |
| `$5E` | `$DE` | INVERSE CHECKER BOARD FILL | `33 33 CC CC 33 33 CC CC` |
| `$5F` | `$DF` | UPPER LEFT TO LOWER RIGHT FILL | `33 99 CC 66 33 99 CC 66` |
| `$60` | `$A0` | NO-BREAK SPACE | `00 00 00 00 00 00 00 00` |
| `$61` | `$A1` | LEFT HALF BLOCK | `F0 F0 F0 F0 F0 F0 F0 F0` |
| `$62` | `$A2` | LOWER HALF BLOCK | `00 00 00 00 FF FF FF FF` |
| `$63` | `$A3` | UPPER ONE EIGHTH BLOCK | `FF 00 00 00 00 00 00 00` |
| `$64` | `$A4` | LOWER ONE EIGHTH BLOCK | `00 00 00 00 00 00 00 FF` |
| `$65` | `$A5` | LEFT ONE EIGHTH BLOCK | `C0 C0 C0 C0 C0 C0 C0 C0` |
| `$66` | `$A6` | MEDIUM SHADE | `CC CC 33 33 CC CC 33 33` |
| `$67` | `$A7` | RIGHT ONE EIGHTH BLOCK | `03 03 03 03 03 03 03 03` |
| `$68` | `$A8` | LOWER HALF MEDIUM SHADE | `00 00 00 00 CC CC 33 33` |
| `$69` | `$A9` | UPPER RIGHT TO LOWER LEFT FILL | `CC 99 33 66 CC 99 33 66` |
| `$6A` | `$AA` | RIGHT ONE QUARTER BLOCK | `03 03 03 03 03 03 03 03` |
| `$6B` | `$AB` | BOX DRAWINGS LIGHT VERTICAL AND RIGHT | `18 18 18 1F 1F 18 18 18` |
| `$6C` | `$AC` | QUADRANT LOWER RIGHT | `00 00 00 00 0F 0F 0F 0F` |
| `$6D` | `$AD` | BOX DRAWINGS LIGHT UP AND RIGHT | `18 18 18 1F 1F 00 00 00` |
| `$6E` | `$AE` | BOX DRAWINGS LIGHT DOWN AND LEFT | `00 00 00 F8 F8 18 18 18` |
| `$6F` | `$AF` | LOWER ONE QUARTER BLOCK | `00 00 00 00 00 00 FF FF` |
| `$70` | `$B0` | BOX DRAWINGS LIGHT DOWN AND RIGHT | `00 00 00 1F 1F 18 18 18` |
| `$71` | `$B1` | BOX DRAWINGS LIGHT UP AND HORIZONTAL | `18 18 18 FF FF 00 00 00` |
| `$72` | `$B2` | BOX DRAWINGS LIGHT DOWN AND HORIZONTAL | `00 00 00 FF FF 18 18 18` |
| `$73` | `$B3` | BOX DRAWINGS LIGHT VERTICAL AND LEFT | `18 18 18 F8 F8 18 18 18` |
| `$74` | `$B4` | LEFT ONE QUARTER BLOCK | `C0 C0 C0 C0 C0 C0 C0 C0` |
| `$75` | `$B5` | LEFT THREE EIGHTHS BLOCK | `E0 E0 E0 E0 E0 E0 E0 E0` |
| `$76` | `$B6` | RIGHT THREE EIGHTHS BLOCK | `07 07 07 07 07 07 07 07` |
| `$77` | `$B7` | UPPER ONE QUARTER BLOCK | `FF FF 00 00 00 00 00 00` |
| `$78` | `$B8` | UPPER THREE EIGHTHS BLOCK | `FF FF FF 00 00 00 00 00` |
| `$79` | `$B9` | LOWER THREE EIGHTHS BLOCK | `00 00 00 00 00 FF FF FF` |
| `$7A` | `$BA` | CHECK MARK | `01 03 06 6C 78 70 60 00` |
| `$7B` | `$BB` | QUADRANT LOWER LEFT | `00 00 00 00 F0 F0 F0 F0` |
| `$7C` | `$BC` | QUADRANT UPPER RIGHT | `0F 0F 0F 0F 00 00 00 00` |
| `$7D` | `$BD` | BOX DRAWINGS LIGHT UP AND LEFT | `18 18 18 F8 F8 00 00 00` |
| `$7E` | `$BE` | QUADRANT UPPER LEFT | `F0 F0 F0 F0 00 00 00 00` |
| `$7F` | `$BF` | QUADRANT UPPER LEFT AND LOWER RIGHT | `F0 F0 F0 F0 0F 0F 0F 0F` |
| `$80` | `$40` | (reverse video) | `C3 99 91 91 9F 99 C3 FF` |
| `$81` | `$41` | (reverse video) | `FF FF C3 F9 C1 99 C1 FF` |
| `$82` | `$42` | (reverse video) | `FF 9F 9F 83 99 99 83 FF` |
| `$83` | `$43` | (reverse video) | `FF FF C3 9F 9F 9F C3 FF` |
| `$84` | `$44` | (reverse video) | `FF F9 F9 C1 99 99 C1 FF` |
| `$85` | `$45` | (reverse video) | `FF FF C3 99 81 9F C3 FF` |
| `$86` | `$46` | (reverse video) | `FF F1 E7 C1 E7 E7 E7 FF` |
| `$87` | `$47` | (reverse video) | `FF FF C1 99 99 C1 F9 83` |
| `$88` | `$48` | (reverse video) | `FF 9F 9F 83 99 99 99 FF` |
| `$89` | `$49` | (reverse video) | `FF E7 FF C7 E7 E7 C3 FF` |
| `$8A` | `$4A` | (reverse video) | `FF F9 FF F9 F9 F9 F9 C3` |
| `$8B` | `$4B` | (reverse video) | `FF 9F 9F 93 87 93 99 FF` |
| `$8C` | `$4C` | (reverse video) | `FF C7 E7 E7 E7 E7 C3 FF` |
| `$8D` | `$4D` | (reverse video) | `FF FF 99 80 80 94 9C FF` |
| `$8E` | `$4E` | (reverse video) | `FF FF 83 99 99 99 99 FF` |
| `$8F` | `$4F` | (reverse video) | `FF FF C3 99 99 99 C3 FF` |
| `$90` | `$50` | (reverse video) | `FF FF 83 99 99 83 9F 9F` |
| `$91` | `$51` | (reverse video) | `FF FF C1 99 99 C1 F9 F9` |
| `$92` | `$52` | (reverse video) | `FF FF 83 99 9F 9F 9F FF` |
| `$93` | `$53` | (reverse video) | `FF FF C1 9F C3 F9 83 FF` |
| `$94` | `$54` | (reverse video) | `FF E7 81 E7 E7 E7 F1 FF` |
| `$95` | `$55` | (reverse video) | `FF FF 99 99 99 99 C1 FF` |
| `$96` | `$56` | (reverse video) | `FF FF 99 99 99 C3 E7 FF` |
| `$97` | `$57` | (reverse video) | `FF FF 9C 94 80 C1 C9 FF` |
| `$98` | `$58` | (reverse video) | `FF FF 99 C3 E7 C3 99 FF` |
| `$99` | `$59` | (reverse video) | `FF FF 99 99 99 C1 F3 87` |
| `$9A` | `$5A` | (reverse video) | `FF FF 81 F3 E7 CF 81 FF` |
| `$9B` | `$5B` | (reverse video) | `C3 CF CF CF CF CF C3 FF` |
| `$9C` | `$5C` | (reverse video) | `F3 ED CF 83 CF 9D 03 FF` |
| `$9D` | `$5D` | (reverse video) | `C3 F3 F3 F3 F3 F3 C3 FF` |
| `$9E` | `$5E` | (reverse video) | `FF E7 C3 81 E7 E7 E7 E7` |
| `$9F` | `$5F` | (reverse video) | `FF EF CF 80 80 CF EF FF` |
| `$A0` | `$20` | (reverse video) | `FF FF FF FF FF FF FF FF` |
| `$A1` | `$21` | (reverse video) | `E7 E7 E7 E7 FF FF E7 FF` |
| `$A2` | `$22` | (reverse video) | `99 99 99 FF FF FF FF FF` |
| `$A3` | `$23` | (reverse video) | `99 99 00 99 00 99 99 FF` |
| `$A4` | `$24` | (reverse video) | `E7 C1 9F C3 F9 83 E7 FF` |
| `$A5` | `$25` | (reverse video) | `9D 99 F3 E7 CF 99 B9 FF` |
| `$A6` | `$26` | (reverse video) | `C3 99 C3 C7 98 99 C0 FF` |
| `$A7` | `$27` | (reverse video) | `F9 F3 E7 FF FF FF FF FF` |
| `$A8` | `$28` | (reverse video) | `F3 E7 CF CF CF E7 F3 FF` |
| `$A9` | `$29` | (reverse video) | `CF E7 F3 F3 F3 E7 CF FF` |
| `$AA` | `$2A` | (reverse video) | `FF 99 C3 00 C3 99 FF FF` |
| `$AB` | `$2B` | (reverse video) | `FF E7 E7 81 E7 E7 FF FF` |
| `$AC` | `$2C` | (reverse video) | `FF FF FF FF FF E7 E7 CF` |
| `$AD` | `$2D` | (reverse video) | `FF FF FF 81 FF FF FF FF` |
| `$AE` | `$2E` | (reverse video) | `FF FF FF FF FF E7 E7 FF` |
| `$AF` | `$2F` | (reverse video) | `FF FC F9 F3 E7 CF 9F FF` |
| `$B0` | `$30` | (reverse video) | `C3 99 91 89 99 99 C3 FF` |
| `$B1` | `$31` | (reverse video) | `E7 E7 C7 E7 E7 E7 81 FF` |
| `$B2` | `$32` | (reverse video) | `C3 99 F9 F3 CF 9F 81 FF` |
| `$B3` | `$33` | (reverse video) | `C3 99 F9 E3 F9 99 C3 FF` |
| `$B4` | `$34` | (reverse video) | `F9 F1 E1 99 80 F9 F9 FF` |
| `$B5` | `$35` | (reverse video) | `81 9F 83 F9 F9 99 C3 FF` |
| `$B6` | `$36` | (reverse video) | `C3 99 9F 83 99 99 C3 FF` |
| `$B7` | `$37` | (reverse video) | `81 99 F3 E7 E7 E7 E7 FF` |
| `$B8` | `$38` | (reverse video) | `C3 99 99 C3 99 99 C3 FF` |
| `$B9` | `$39` | (reverse video) | `C3 99 99 C1 F9 99 C3 FF` |
| `$BA` | `$3A` | (reverse video) | `FF FF E7 FF FF E7 FF FF` |
| `$BB` | `$3B` | (reverse video) | `FF FF E7 FF FF E7 E7 CF` |
| `$BC` | `$3C` | (reverse video) | `F1 E7 CF 9F CF E7 F1 FF` |
| `$BD` | `$3D` | (reverse video) | `FF FF 81 FF 81 FF FF FF` |
| `$BE` | `$3E` | (reverse video) | `8F E7 F3 F9 F3 E7 8F FF` |
| `$BF` | `$3F` | (reverse video) | `C3 99 F9 F3 E7 FF E7 FF` |
| `$C0` | `$C0` | (reverse video) | `FF FF FF 00 00 FF FF FF` |
| `$C1` | `$C1` | (reverse video) | `E7 C3 99 81 99 99 99 FF` |
| `$C2` | `$C2` | (reverse video) | `83 99 99 83 99 99 83 FF` |
| `$C3` | `$C3` | (reverse video) | `C3 99 9F 9F 9F 99 C3 FF` |
| `$C4` | `$C4` | (reverse video) | `87 93 99 99 99 93 87 FF` |
| `$C5` | `$C5` | (reverse video) | `81 9F 9F 87 9F 9F 81 FF` |
| `$C6` | `$C6` | (reverse video) | `81 9F 9F 87 9F 9F 9F FF` |
| `$C7` | `$C7` | (reverse video) | `C3 99 9F 91 99 99 C3 FF` |
| `$C8` | `$C8` | (reverse video) | `99 99 99 81 99 99 99 FF` |
| `$C9` | `$C9` | (reverse video) | `C3 E7 E7 E7 E7 E7 C3 FF` |
| `$CA` | `$CA` | (reverse video) | `E1 F3 F3 F3 F3 93 C7 FF` |
| `$CB` | `$CB` | (reverse video) | `99 93 87 8F 87 93 99 FF` |
| `$CC` | `$CC` | (reverse video) | `9F 9F 9F 9F 9F 9F 81 FF` |
| `$CD` | `$CD` | (reverse video) | `9C 88 80 94 9C 9C 9C FF` |
| `$CE` | `$CE` | (reverse video) | `99 89 81 81 91 99 99 FF` |
| `$CF` | `$CF` | (reverse video) | `C3 99 99 99 99 99 C3 FF` |
| `$D0` | `$D0` | (reverse video) | `83 99 99 83 9F 9F 9F FF` |
| `$D1` | `$D1` | (reverse video) | `C3 99 99 99 99 C3 F1 FF` |
| `$D2` | `$D2` | (reverse video) | `83 99 99 83 87 93 99 FF` |
| `$D3` | `$D3` | (reverse video) | `C3 99 9F C3 F9 99 C3 FF` |
| `$D4` | `$D4` | (reverse video) | `81 E7 E7 E7 E7 E7 E7 FF` |
| `$D5` | `$D5` | (reverse video) | `99 99 99 99 99 99 C3 FF` |
| `$D6` | `$D6` | (reverse video) | `99 99 99 99 99 C3 E7 FF` |
| `$D7` | `$D7` | (reverse video) | `9C 9C 9C 94 80 88 9C FF` |
| `$D8` | `$D8` | (reverse video) | `99 99 C3 E7 C3 99 99 FF` |
| `$D9` | `$D9` | (reverse video) | `99 99 99 C3 E7 E7 E7 FF` |
| `$DA` | `$DA` | (reverse video) | `81 F9 F3 E7 CF 9F 81 FF` |
| `$DB` | `$DB` | (reverse video) | `E7 E7 E7 00 00 E7 E7 E7` |
| `$DC` | `$DC` | (reverse video) | `3F 3F CF CF 3F 3F CF CF` |
| `$DD` | `$DD` | (reverse video) | `E7 E7 E7 E7 E7 E7 E7 E7` |
| `$DE` | `$DE` | (reverse video) | `CC CC 33 33 CC CC 33 33` |
| `$DF` | `$DF` | (reverse video) | `CC 66 33 99 CC 66 33 99` |
| `$E0` | `$A0` | (reverse video) | `FF FF FF FF FF FF FF FF` |
| `$E1` | `$A1` | (reverse video) | `0F 0F 0F 0F 0F 0F 0F 0F` |
| `$E2` | `$A2` | (reverse video) | `FF FF FF FF 00 00 00 00` |
| `$E3` | `$A3` | (reverse video) | `00 FF FF FF FF FF FF FF` |
| `$E4` | `$A4` | (reverse video) | `FF FF FF FF FF FF FF 00` |
| `$E5` | `$A5` | (reverse video) | `3F 3F 3F 3F 3F 3F 3F 3F` |
| `$E6` | `$A6` | (reverse video) | `33 33 CC CC 33 33 CC CC` |
| `$E7` | `$A7` | (reverse video) | `FC FC FC FC FC FC FC FC` |
| `$E8` | `$A8` | (reverse video) | `FF FF FF FF 33 33 CC CC` |
| `$E9` | `$A9` | (reverse video) | `33 66 CC 99 33 66 CC 99` |
| `$EA` | `$AA` | (reverse video) | `FC FC FC FC FC FC FC FC` |
| `$EB` | `$AB` | (reverse video) | `E7 E7 E7 E0 E0 E7 E7 E7` |
| `$EC` | `$AC` | (reverse video) | `FF FF FF FF F0 F0 F0 F0` |
| `$ED` | `$AD` | (reverse video) | `E7 E7 E7 E0 E0 FF FF FF` |
| `$EE` | `$AE` | (reverse video) | `FF FF FF 07 07 E7 E7 E7` |
| `$EF` | `$AF` | (reverse video) | `FF FF FF FF FF FF 00 00` |
| `$F0` | `$B0` | (reverse video) | `FF FF FF E0 E0 E7 E7 E7` |
| `$F1` | `$B1` | (reverse video) | `E7 E7 E7 00 00 FF FF FF` |
| `$F2` | `$B2` | (reverse video) | `FF FF FF 00 00 E7 E7 E7` |
| `$F3` | `$B3` | (reverse video) | `E7 E7 E7 07 07 E7 E7 E7` |
| `$F4` | `$B4` | (reverse video) | `3F 3F 3F 3F 3F 3F 3F 3F` |
| `$F5` | `$B5` | (reverse video) | `1F 1F 1F 1F 1F 1F 1F 1F` |
| `$F6` | `$B6` | (reverse video) | `F8 F8 F8 F8 F8 F8 F8 F8` |
| `$F7` | `$B7` | (reverse video) | `00 00 FF FF FF FF FF FF` |
| `$F8` | `$B8` | (reverse video) | `00 00 00 FF FF FF FF FF` |
| `$F9` | `$B9` | (reverse video) | `FF FF FF FF FF 00 00 00` |
| `$FA` | `$BA` | (reverse video) | `FE FC F9 93 87 8F 9F FF` |
| `$FB` | `$BB` | (reverse video) | `FF FF FF FF 0F 0F 0F 0F` |
| `$FC` | `$BC` | (reverse video) | `F0 F0 F0 F0 FF FF FF FF` |
| `$FD` | `$BD` | (reverse video) | `E7 E7 E7 07 07 FF FF FF` |
| `$FE` | `$BE` | (reverse video) | `0F 0F 0F 0F FF FF FF FF` |
| `$FF` | `$BF` | (reverse video) | `0F 0F 0F 0F F0 F0 F0 F0` |

## constraints
- Agents MUST use screen code as the ROM index, not PETSCII/interchange code.
- Pixel row 0 is the topmost row; row 7 is the bottommost.
- Reverse-video entries (`$80-$FF`) are the ROM bytes verbatim, not derived at runtime.

## sources

- chargen ROM binary: mist64/c64ref src/charset/chargen (SHA 191ac46)
- interchange map: mist64/c64ref src/charset/C64IALT.TXT (Rebecca Bettencourt, 2018-10-11)
- primary set: [chargen-primary.md](chargen-primary.md)
- screen codes: [screen-codes.md](screen-codes.md)
- VIC-II character base: [../io/vic-ii.md](../io/vic-ii.md)
