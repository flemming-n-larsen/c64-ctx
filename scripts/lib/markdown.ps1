# Shared Markdown helpers for scripts/audit.ps1 and scripts/generate-routes.ps1.
# Both scripts MUST dot-source this file rather than carrying their own copies,
# so the front-matter parser cannot fork between validation and generation.

function Get-ContentWithoutFences([string]$content) {
    $insideFence = $false
    $kept = foreach ($line in ($content -split "`r?`n")) {
        if ($line -match '^\s*(```|~~~)') {
            $insideFence = -not $insideFence
            continue
        }
        if (-not $insideFence) { $line }
    }
    return $kept -join "`n"
}

function Get-FrontMatter([string]$content) {
    $metadata = @{}
    $lines = $content -split "`r?`n"
    if ($lines.Count -eq 0 -or $lines[0] -ne '---') { return $metadata }
    for ($i = 1; $i -lt $lines.Count -and $lines[$i] -ne '---'; $i++) {
        if ($lines[$i] -match '^([A-Za-z0-9_-]+):\s*(.*)$') {
            $metadata[$matches[1]] = $matches[2].Trim()
        }
    }
    return $metadata
}

function Get-CanonicalDomain([string]$relativePath) {
    $directory = [IO.Path]::GetDirectoryName($relativePath).Replace('\', '/')
    if ([string]::IsNullOrWhiteSpace($directory)) { return 'root' }
    return $directory
}

# Front-matter values are stored raw; strip the optional surrounding quotes.
function Get-FrontMatterString([hashtable]$metadata, [string]$key) {
    if (-not $metadata.ContainsKey($key)) { return '' }
    $value = $metadata[$key].Trim()
    if ($value.Length -ge 2 -and $value.StartsWith('"') -and $value.EndsWith('"')) {
        $value = $value.Substring(1, $value.Length - 2)
    }
    return $value
}

# keywords MUST be YAML flow style ([a, b, c]); the line-by-line parser above
# cannot see block lists, so a block list would silently read as empty.
function Get-FrontMatterList([hashtable]$metadata, [string]$key) {
    $value = Get-FrontMatterString $metadata $key
    if ([string]::IsNullOrWhiteSpace($value)) { return @() }
    if (-not ($value.StartsWith('[') -and $value.EndsWith(']'))) { return @() }
    $inner = $value.Substring(1, $value.Length - 2)
    if ([string]::IsNullOrWhiteSpace($inner)) { return @() }
    return @($inner -split ',' | ForEach-Object { $_.Trim().Trim('"').Trim("'") } | Where-Object { $_ })
}

function Get-CorpusMarkdownFiles([string]$repoRoot) {
    return Get-ChildItem -LiteralPath $repoRoot -Recurse -Filter '*.md' -File |
        Where-Object { $_.FullName -notmatch '[\\/](\.git|\.junie|\.idea)[\\/]' }
}
