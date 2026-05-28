# Attribution

This repository derives facts, data, and structure from the following upstream sources.

## mist64/c64ref

- Repository: https://github.com/mist64/c64ref
- Author: Michael Steil
- License: BSD 2-Clause

The CPU reference, memory map, I/O register data, KERNAL API, BASIC/KERNAL ROM
disassembly routes, character set data, and color palette in this repository are
extracted or derived from mist64/c64ref.

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
