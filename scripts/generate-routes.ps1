<#
.SYNOPSIS
    Generates the routing layer from leaf-page front matter.

.DESCRIPTION
    Writes three kinds of artifact, all derived -- never hand-edit them:
      ROUTE.md    one row per leaf page: page, summary, keywords (grep target)
      SYMBOLS.md  address / KERNAL symbol -> authoritative page (grep target)
      */INDEX.md  the ## routes block between the GENERATED:routes markers

    Run with -Check to verify the committed artifacts match what the current
    front matter would produce. scripts/audit.ps1 calls it that way, which is
    what makes drift between the pages and the index layer impossible.

.EXAMPLE
    ./scripts/generate-routes.ps1
    ./scripts/generate-routes.ps1 -Check
#>
param(
    [switch]$Check
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path $PSScriptRoot -Parent
. (Join-Path $PSScriptRoot 'lib/markdown.ps1')

$rootDocs = @('INDEX.md', 'README.md', 'AGENTS.md', 'STYLE.md', 'ATTRIBUTION.md', 'PLAN.md', 'ROUTE.md', 'SYMBOLS.md')

# A page listing this many distinct addresses is bulk data, not the place an
# agent should be sent for one register. Without the cap, $D018 alone resolves
# to dozens of pages and SYMBOLS.md becomes noise.
$bulkAddressThreshold = 60

# Domains that own raw hardware and address facts; preferred as the
# authoritative page for a symbol when several pages mention it.
$authoritativeDomains = @('io', 'memory', 'kernal', 'charset', 'sid')

# Uppercase words that are prose, product names, or units rather than symbols an
# agent would look up. Without this the symbol table fills with BASIC, ASCII, C64.
$symbolStopList = @(
    'ACME', 'API', 'ASCII', 'BASIC', 'BYTE', 'CBM', 'CPU', 'DMA', 'FPS', 'GUI',
    'HVSC', 'IDE', 'JVM', 'KHZ', 'MHZ', 'MUST', 'NOT', 'PAL', 'NTSC', 'RAM',
    'ROM', 'SHOULD', 'MAY', 'THE', 'AND', 'FOR', 'USB', 'PRG', 'SID', 'VIC',
    'CIA', 'KERNAL', 'PETSCII', 'IEEE', 'IEC', 'LSB', 'MSB', 'PCM', 'PWM',
    'RGB', 'URL', 'XML', 'YES', 'C64', 'C128', 'VICE', 'CCS64', 'HOXS64'
)

$differences = [System.Collections.Generic.List[string]]::new()

function Write-Artifact([string]$relativePath, [string]$content) {
    $full = Join-Path $repoRoot $relativePath
    $existing = ''
    if (Test-Path -LiteralPath $full) {
        $existing = Get-Content -LiteralPath $full -Raw
        if ($null -eq $existing) { $existing = '' }
    }
    $normalisedExisting = $existing -replace "`r`n", "`n"
    if ($normalisedExisting -eq $content) { return }

    if ($Check) {
        $differences.Add($relativePath)
        return
    }
    $parent = Split-Path $full -Parent
    if (-not (Test-Path -LiteralPath $parent)) { New-Item -ItemType Directory -Path $parent | Out-Null }
    Set-Content -LiteralPath $full -Value $content -NoNewline -Encoding utf8
}

# Table cells cannot contain a raw pipe, and a backslash-escaped pipe renders
# badly on GitHub; the corpus does not use pipes in summaries, so replace
# defensively rather than silently producing a broken row.
function Format-Cell([string]$text) {
    return ($text -replace '\|', '/').Trim()
}

# ---------------------------------------------------------------- collect ----

$pages = [System.Collections.Generic.List[object]]::new()

foreach ($file in (Get-CorpusMarkdownFiles $repoRoot)) {
    $relative = [IO.Path]::GetRelativePath($repoRoot, $file.FullName).Replace('\', '/')
    if ($file.Name -eq 'INDEX.md' -or $relative -in $rootDocs) { continue }

    $content = Get-Content -LiteralPath $file.FullName -Raw
    if ($null -eq $content) { $content = '' }
    $metadata = Get-FrontMatter $content
    if ($metadata['type'] -ne 'reference') { continue }

    $body = Get-ContentWithoutFences $content

    # Addresses worth indexing: zero page and the stack, the I/O window, and
    # the CPU vector area. Everything else is data, not a register or entry.
    $addresses = [System.Collections.Generic.HashSet[string]]::new()
    foreach ($m in [regex]::Matches($body, '\$([0-9A-Fa-f]{4})\b')) {
        $hex = $m.Groups[1].Value.ToUpperInvariant()
        $value = [Convert]::ToInt32($hex, 16)
        if (($value -le 0x01FF) -or ($value -ge 0xD000 -and $value -le 0xDFFF) -or ($value -ge 0xFF00)) {
            [void]$addresses.Add('$' + $hex)
        }
    }

    # Uppercase identifiers in the first column of a lookup table: KERNAL
    # entry names, register mnemonics, BASIC keywords.
    $symbols = [System.Collections.Generic.HashSet[string]]::new()
    # A page that *defines* a symbol gives it a table row of its own. That is a
    # far stronger claim to authority than a passing mention in prose, and it is
    # what keeps $D018 pointing at io/vic-ii.md instead of a charset dump that
    # happens to name the register.
    $rowKeys = [System.Collections.Generic.HashSet[string]]::new()
    foreach ($line in ($body -split "`n")) {
        if ($line -notmatch '^\|') { continue }
        $cells = $line.Trim().Trim('|') -split '\|'
        if ($cells.Count -lt 2) { continue }
        $key = $cells[0].Trim().Trim('`').Trim()
        if ($key -match '^\$([0-9A-Fa-f]{4})$') {
            [void]$rowKeys.Add('$' + $matches[1].ToUpperInvariant())
        }
        elseif ($key -match '^[A-Z][A-Z0-9]{2,7}$' -and $key -notin $symbolStopList -and $key -notmatch '^[0-9A-F]{4}$') {
            [void]$rowKeys.Add($key)
        }
        foreach ($m in [regex]::Matches($cells[0], '\b([A-Z][A-Z0-9]{2,7})\b')) {
            $candidate = $m.Groups[1].Value
            # Reject hex fragments left over from ranges such as `$A000-$BFFF`.
            if ($candidate -match '^[0-9A-F]{4}$') { continue }
            if ($candidate -in $symbolStopList) { continue }
            [void]$symbols.Add($candidate)
        }
    }

    $pages.Add([pscustomobject]@{
        Path      = $relative
        Domain    = $metadata['domain']
        Summary   = Get-FrontMatterString $metadata 'summary'
        Keywords  = Get-FrontMatterList $metadata 'keywords'
        Addresses = $addresses
        Symbols   = $symbols
        RowKeys   = $rowKeys
        # Filename stem tokens are recoverable by regex, so they are added to
        # the generated keyword column rather than written into front matter.
        Stem      = ([IO.Path]::GetFileNameWithoutExtension($relative) -replace '-', ' ')
    })
}

$pages = @($pages | Sort-Object Path)

# --------------------------------------------------------------- ROUTE.md ----

$routeLines = [System.Collections.Generic.List[string]]::new()
$routeLines.Add('---')
$routeLines.Add('type: index')
$routeLines.Add('domain: root')
$routeLines.Add('source: cross-domain')
$routeLines.Add('---')
$routeLines.Add('')
$routeLines.Add('<!-- GENERATED by scripts/generate-routes.ps1 -- do not edit; run the script instead. -->')
$routeLines.Add('')
$routeLines.Add('Search this file for a topic or term, then read the matched page. Do not read it whole -- for a')
$routeLines.Add('whole-file entry point use [INDEX.md](INDEX.md); for a `$`-address or KERNAL symbol use')
$routeLines.Add('[SYMBOLS.md](SYMBOLS.md).')
$routeLines.Add('')
$routeLines.Add('## route')
$routeLines.Add('| page | answers | terms |')
$routeLines.Add('|---|---|---|')

foreach ($page in $pages) {
    $terms = [System.Collections.Generic.List[string]]::new()
    foreach ($k in $page.Keywords) { $terms.Add($k) }
    if ($page.Stem -and ($terms -notcontains $page.Stem)) { $terms.Add($page.Stem) }
    $routeLines.Add("| [$($page.Path)]($($page.Path)) | $(Format-Cell $page.Summary) | $(Format-Cell ($terms -join ', ')) |")
}

$routeLines.Add('')
Write-Artifact 'ROUTE.md' (($routeLines -join "`n"))

# ------------------------------------------------------------- SYMBOLS.md ----

$symbolOwners = @{}

function Add-SymbolOwner([string]$symbol, $page) {
    if (-not $symbolOwners.ContainsKey($symbol)) {
        $symbolOwners[$symbol] = [System.Collections.Generic.List[object]]::new()
    }
    $symbolOwners[$symbol].Add($page)
}

foreach ($page in $pages) {
    # The bulk cap keeps character-ROM and frequency dumps out of the address
    # index; it MUST NOT hide their named symbols, which are still worth routing.
    if ($page.Addresses.Count -le $bulkAddressThreshold) {
        foreach ($a in $page.Addresses) { Add-SymbolOwner $a $page }
    }
    foreach ($s in $page.Symbols) { Add-SymbolOwner $s $page }
}

# Rank, strongest signal first: the page gives the symbol a table row of its own;
# then declares it in keywords; then owns the relevant hardware domain; then is
# the most specific page, measured by how few addresses it covers.
function Get-SymbolRank($page, [string]$symbol) {
    $rowKey = if ($page.RowKeys.Contains($symbol)) { 0 } else { 1 }
    $declared = if ($page.Keywords -contains $symbol.ToLowerInvariant() -or $page.Keywords -contains $symbol) { 0 } else { 1 }
    $domainRank = if ($authoritativeDomains -contains $page.Domain) { 0 } else { 1 }
    return '{0}{1}{2}{3:D5}{4}' -f $rowKey, $declared, $domainRank, $page.Addresses.Count, $page.Path
}

$symbolLines = [System.Collections.Generic.List[string]]::new()
$symbolLines.Add('---')
$symbolLines.Add('type: index')
$symbolLines.Add('domain: root')
$symbolLines.Add('source: cross-domain')
$symbolLines.Add('---')
$symbolLines.Add('')
$symbolLines.Add('<!-- GENERATED by scripts/generate-routes.ps1 -- do not edit; run the script instead. -->')
$symbolLines.Add('')
$symbolLines.Add('Search this file for a `$`-address or a KERNAL/register symbol, then read the authoritative page.')
$symbolLines.Add('Do not read it whole. Bulk data pages (character ROM dumps, full opcode and frequency tables) are')
$symbolLines.Add('deliberately excluded; reach those through [ROUTE.md](ROUTE.md).')
$symbolLines.Add('')
$symbolLines.Add('## symbols')
$symbolLines.Add('| symbol | authoritative page | also in |')
$symbolLines.Add('|---|---|---|')

foreach ($symbol in ($symbolOwners.Keys | Sort-Object)) {
    $owners = @($symbolOwners[$symbol] | Sort-Object -Property @{ Expression = { Get-SymbolRank $_ $symbol } })
    $primary = $owners[0]
    # Bare paths, not links: SYMBOLS.md must not manufacture inbound links that
    # would make the audit's orphan check vacuous.
    $also = @($owners | Select-Object -Skip 1 | Select-Object -First 4 | ForEach-Object { $_.Path })
    $alsoCell = if ($also.Count -gt 0) { $also -join ', ' } else { '' }
    $symbolLines.Add("| ``$symbol`` | [$($primary.Path)]($($primary.Path)) | $alsoCell |")
}

$symbolLines.Add('')
Write-Artifact 'SYMBOLS.md' (($symbolLines -join "`n"))

# ------------------------------------------------- domain ## routes blocks ----

$startMarker = '<!-- GENERATED:routes -->'
$endMarker = '<!-- /GENERATED:routes -->'

foreach ($group in ($pages | Group-Object Domain)) {
    $domain = $group.Name
    $indexRelative = "$domain/INDEX.md"
    $indexFull = Join-Path $repoRoot $indexRelative
    if (-not (Test-Path -LiteralPath $indexFull)) { continue }

    $block = [System.Collections.Generic.List[string]]::new()
    $block.Add($startMarker)
    $block.Add('| answers | read | terms |')
    $block.Add('|---|---|---|')
    foreach ($page in ($group.Group | Sort-Object Path)) {
        $leaf = [IO.Path]::GetFileName($page.Path)
        $block.Add("| $(Format-Cell $page.Summary) | [$leaf]($leaf) | $(Format-Cell ($page.Keywords -join ', ')) |")
    }
    $block.Add($endMarker)
    $blockText = $block -join "`n"

    $existing = (Get-Content -LiteralPath $indexFull -Raw) -replace "`r`n", "`n"
    # (?s) is required: -match and Replace both default to '.' not spanning
    # newlines, and without it a second run appends a duplicate block.
    $pattern = '(?s)' + [regex]::Escape($startMarker) + '.*?' + [regex]::Escape($endMarker)
    if ($existing -match $pattern) {
        $updated = [regex]::Replace($existing, $pattern, { $blockText })
    }
    elseif ($existing -match '(?m)^## related\s*$') {
        # Insert ahead of ## related so the page reads routes -> pages -> related.
        $updated = [regex]::Replace(
            $existing,
            '(?m)^## related\s*$',
            { "## pages`n" + $blockText + "`n`n## related" },
            1)
    }
    else {
        $updated = $existing.TrimEnd("`n") + "`n`n## pages`n" + $blockText + "`n"
    }
    Write-Artifact $indexRelative $updated
}

# ---------------------------------------------------------------- report ----

if ($Check) {
    if ($differences.Count -gt 0) {
        Write-Host "Generated routing layer is stale:" -ForegroundColor Red
        foreach ($d in ($differences | Sort-Object)) { Write-Host "  $d" -ForegroundColor Red }
        Write-Host "Run scripts/generate-routes.ps1 to regenerate." -ForegroundColor Red
        exit 1
    }
    Write-Host "Routing layer is current: $($pages.Count) pages, $($symbolOwners.Count) symbols."
    exit 0
}

Write-Host "Generated ROUTE.md ($($pages.Count) pages) and SYMBOLS.md ($($symbolOwners.Count) symbols)."
