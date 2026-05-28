---
type: reference
domain: basic
granularity: family
---

## facts
- BASIC V2 defines 76 reserved keywords/operators occupying token bytes `$80-$CB`.
- Statements (e.g., `PRINT`, `POKE`, `IF`) execute inside programs and in immediate mode.
- Commands (e.g., `RUN`, `LIST`, `LOAD`, `NEW`) are typically issued in immediate mode but parse anywhere.
- Operators (`+`, `-`, `*`, `/`, `↑`, `AND`, `OR`, `NOT`, `>`, `=`, `<`) are tokenized like keywords.
- Clauses (`THEN`, `TO`, `STEP`, `FN`, `TAB(`, `SPC(`, `GO`) are syntactic sub-parts of larger statements and never stand alone.
- Functions (e.g., `ABS`, `CHR$`, `PEEK`, `INT`) occupy tokens `$B4-$CA` and are documented in [functions.md](functions.md); they are omitted from the table below to avoid duplication.

## lookup
| keyword | token | type | syntax | example |
|---|---:|---|---|---|
| `END` | `$80` | statement | `END` | `END` |
| `FOR` | `$81` | statement | `FOR var=start TO end [STEP n]` | `FOR I=1 TO 10` |
| `NEXT` | `$82` | statement | `NEXT [var[,var...]]` | `NEXT I` |
| `DATA` | `$83` | statement | `DATA const[,const...]` | `DATA 1,2,"HI"` |
| `INPUT#` | `$84` | statement | `INPUT# file,var[,var...]` | `INPUT#2,A$` |
| `INPUT` | `$85` | statement | `INPUT ["prompt";] var[,var...]` | `INPUT "NAME";N$` |
| `DIM` | `$86` | statement | `DIM var(dim1[,dim2...])[,...]` | `DIM A(10,10)` |
| `READ` | `$87` | statement | `READ var[,var...]` | `READ A,B$` |
| `LET` | `$88` | statement | `[LET] var=expr` | `LET A=5` |
| `GOTO` | `$89` | statement | `GOTO line` | `GOTO 100` |
| `RUN` | `$8A` | command | `RUN [line]` | `RUN 100` |
| `IF` | `$8B` | statement | `IF expr THEN line\|statement` | `IF A>5 THEN 100` |
| `RESTORE` | `$8C` | statement | `RESTORE` | `RESTORE` |
| `GOSUB` | `$8D` | statement | `GOSUB line` | `GOSUB 500` |
| `RETURN` | `$8E` | statement | `RETURN` | `RETURN` |
| `REM` | `$8F` | statement | `REM text` | `REM MAIN LOOP` |
| `STOP` | `$90` | statement | `STOP` | `STOP` |
| `ON` | `$91` | statement | `ON expr GOTO\|GOSUB line[,line...]` | `ON X GOTO 10,20,30` |
| `WAIT` | `$92` | statement | `WAIT addr,mask[,xor]` | `WAIT 197,64` |
| `LOAD` | `$93` | command | `LOAD ["name"[,dev[,sec]]]` | `LOAD "*",8,1` |
| `SAVE` | `$94` | command | `SAVE ["name"[,dev[,sec]]]` | `SAVE "PROG",8` |
| `VERIFY` | `$95` | command | `VERIFY ["name"[,dev[,sec]]]` | `VERIFY "PROG",8` |
| `DEF` | `$96` | statement | `DEF FN name(var)=expr` | `DEF FN S(X)=X*X` |
| `POKE` | `$97` | statement | `POKE addr,byte` | `POKE 53280,0` |
| `PRINT#` | `$98` | statement | `PRINT# file,list` | `PRINT#2,A$` |
| `PRINT` | `$99` | statement | `PRINT [list]` | `PRINT "HELLO"` |
| `CONT` | `$9A` | command | `CONT` | `CONT` |
| `LIST` | `$9B` | command | `LIST [range]` | `LIST 100-200` |
| `CLR` | `$9C` | command | `CLR` | `CLR` |
| `CMD` | `$9D` | statement | `CMD file[,list]` | `CMD 4,"HEADER"` |
| `SYS` | `$9E` | statement | `SYS addr` | `SYS 49152` |
| `OPEN` | `$9F` | statement | `OPEN file,dev[,sec[,"name"]]` | `OPEN 2,8,2,"DATA,S,R"` |
| `CLOSE` | `$A0` | statement | `CLOSE file` | `CLOSE 2` |
| `GET` | `$A1` | statement | `GET var[,var...]` | `GET A$` |
| `NEW` | `$A2` | command | `NEW` | `NEW` |
| `TAB(` | `$A3` | clause | `TAB(col)` | `PRINT TAB(10);"X"` |
| `TO` | `$A4` | clause | `FOR ... TO end` | `FOR I=1 TO 10` |
| `FN` | `$A5` | clause | `FN name(expr)` | `Y=FN S(3)` |
| `SPC(` | `$A6` | clause | `SPC(n)` | `PRINT SPC(5);"X"` |
| `THEN` | `$A7` | clause | `IF expr THEN ...` | `IF A=0 THEN 100` |
| `NOT` | `$A8` | operator | `NOT expr` | `IF NOT A THEN 100` |
| `STEP` | `$A9` | clause | `FOR ... TO end STEP n` | `FOR I=10 TO 1 STEP -1` |
| `+` | `$AA` | operator | `expr + expr` | `A=B+C` |
| `-` | `$AB` | operator | `expr - expr` or `-expr` | `A=B-C` |
| `*` | `$AC` | operator | `expr * expr` | `A=B*C` |
| `/` | `$AD` | operator | `expr / expr` | `A=B/C` |
| `↑` | `$AE` | operator | `expr ↑ expr` | `A=B↑2` |
| `AND` | `$AF` | operator | `expr AND expr` | `IF A>0 AND B>0 THEN 100` |
| `OR` | `$B0` | operator | `expr OR expr` | `IF A=0 OR B=0 THEN 100` |
| `>` | `$B1` | operator | `expr > expr` | `IF A>5 THEN 100` |
| `=` | `$B2` | operator | `expr = expr` | `IF A=5 THEN 100` |
| `<` | `$B3` | operator | `expr < expr` | `IF A<5 THEN 100` |
| `GO` | `$CB` | clause | `GO TO line` | `GO TO 100` |

## constraints
- Multiple statements on one line MUST be separated by `:`.
- `LET` MAY be omitted; bare assignments like `A=5` are valid statements.
- `IF...THEN` accepts either a target line number or a statement to execute when the expression is true.
- `REM` consumes the rest of the line; bytes after `REM` are NOT tokenized and SHOULD be treated as ASCII text.
- Operator precedence (highest to lowest): unary `-`, `↑`, `*` and `/`, `+` and `-`, comparisons (`<` `=` `>`), `NOT`, `AND`, `OR`.
- `GO TO` tokenizes as two bytes (`GO` `$CB` + `TO` `$A4`); `GOTO` tokenizes as one byte (`$89`); both parse identically at runtime.
- Tokens `$B4-$CA` are reserved for functions and MUST be looked up in [functions.md](functions.md).
- Keywords MUST match longest-prefix at tokenization (e.g., `INPUT#` is matched before `INPUT`).
- Token `$FF` denotes the function `π` (PI) and is documented in [functions.md](functions.md).

## links
- token bytes and tokenizer: [tokens.md](tokens.md)
- function keywords (`$B4-$CA`): [functions.md](functions.md)
- line layout and listing format: [program-structure.md](program-structure.md)
- runtime error codes: [errors.md](errors.md)
- `OPEN`/`CLOSE`/`PRINT#`/`INPUT#`/`GET`/`CMD` device I/O: [io.md](io.md)
- `SYS` and `POKE` for machine code: [machine-code-bridge.md](machine-code-bridge.md)
- variable typing rules for `LET`/`DIM`/`READ`/`INPUT`: [variables.md](variables.md)

## sources
- local route: [../sources/INDEX.md](../sources/INDEX.md)
- token byte assignments: [tokens.md](tokens.md)
- BASIC index: [INDEX.md](INDEX.md)
