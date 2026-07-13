param(
    [switch]$CheckExternal
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path $PSScriptRoot -Parent
$allowedSources = @(
    '6502.org',
    'assembler-docs',
    'c64ref',
    'codebase64.net',
    'commodore-manual',
    'cross-domain',
    'hvsc',
    'mixed',
    'tool-docs'
)
$orphanAllowList = @('tasks/raster-interrupt.md')
$errors = [System.Collections.Generic.List[string]]::new()
$warnings = [System.Collections.Generic.List[string]]::new()
$linkedFiles = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
$externalUrls = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)

function Add-AuditError([string]$message) {
    $errors.Add($message)
}

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

$markdownFiles = Get-ChildItem -LiteralPath $repoRoot -Recurse -Filter '*.md' -File |
    Where-Object { $_.FullName -notmatch '[\\/](\.git|\.junie|\.idea)[\\/]' }

foreach ($file in $markdownFiles) {
    $relative = [IO.Path]::GetRelativePath($repoRoot, $file.FullName).Replace('\', '/')
    $content = Get-Content -LiteralPath $file.FullName -Raw
    if ($null -eq $content) { $content = '' }
    $scanContent = Get-ContentWithoutFences $content

    if ($relative -notin @('README.md', 'ATTRIBUTION.md')) {
        $metadata = Get-FrontMatter $content
        if (-not $metadata.ContainsKey('type')) { Add-AuditError "${relative}: missing front-matter type" }
        if (-not $metadata.ContainsKey('domain')) { Add-AuditError "${relative}: missing front-matter domain" }

        if ($metadata.ContainsKey('domain')) {
            $expectedDomain = Get-CanonicalDomain $relative
            if ($metadata['domain'] -ne $expectedDomain) {
                Add-AuditError "${relative}: domain '$($metadata['domain'])' does not match '$expectedDomain'"
            }
        }

        if ($metadata['type'] -eq 'reference') {
            if (-not $metadata.ContainsKey('granularity')) {
                Add-AuditError "${relative}: reference is missing granularity"
            }
            if ($content -notmatch '(?m)^## sources\s*$') {
                Add-AuditError "${relative}: reference is missing ## sources"
            }
        }

        if ($metadata.ContainsKey('source') -and $metadata['source'] -notin $allowedSources) {
            Add-AuditError "${relative}: unknown source identifier '$($metadata['source'])'"
        }
    }

    if ($scanContent -match '(?m)^\|[^\r\n]*\|\s*planned(?: seed)?\s*\|') {
        Add-AuditError "${relative}: stale planned coverage status"
    }

    foreach ($match in [regex]::Matches($scanContent, '(?<!\!)\[[^\]]+\]\(([^)]+)\)')) {
        $target = $match.Groups[1].Value.Trim()
        if ($target -match '^(https?://|mailto:|#)') { continue }
        $pathPart = [uri]::UnescapeDataString(($target -split '#')[0])
        if ([string]::IsNullOrWhiteSpace($pathPart)) { continue }
        $resolved = [IO.Path]::GetFullPath((Join-Path $file.DirectoryName $pathPart))
        if (-not (Test-Path -LiteralPath $resolved)) {
            Add-AuditError "${relative}: broken local link '$target'"
            continue
        }
        [void]$linkedFiles.Add($resolved)
    }

    foreach ($match in [regex]::Matches($scanContent, 'https?://[^\s)>]+')) {
        $url = ($match.Value -split '\]\(')[0].TrimEnd('.', ',', ';')
        [void]$externalUrls.Add($url)
    }
}

foreach ($file in $markdownFiles) {
    $relative = [IO.Path]::GetRelativePath($repoRoot, $file.FullName).Replace('\', '/')
    if ($file.Name -in @('INDEX.md', 'README.md', 'AGENTS.md', 'STYLE.md', 'ATTRIBUTION.md')) { continue }
    if ($relative -in $orphanAllowList) { continue }
    if (-not $linkedFiles.Contains($file.FullName)) {
        Add-AuditError "${relative}: factual page has no inbound local link"
    }
}

if ($CheckExternal) {
    Write-Host "Checking $($externalUrls.Count) external URLs..."
    $urlResults = $externalUrls | ForEach-Object -Parallel {
        $url = $_
        try {
            if ($url -match '^https://codebase64\.net/') {
                $response = Invoke-WebRequest -Uri $url -Method Get -MaximumRedirection 8 -TimeoutSec 20 -SkipHttpErrorCheck -UserAgent 'c64-ctx-source-audit'
                $missingTopic = $response.Content -match '(?i)this topic does not exist|topic does not exist yet|page does not exist'
                [pscustomobject]@{ Url = $url; Status = [int]$response.StatusCode; Error = $(if ($missingTopic) { 'DokuWiki topic does not exist' } else { '' }) }
            }
            elseif ($url -match '^https://kodiak64\.co\.uk/') {
                # Kodiak64 can be slow to answer HEAD requests from hosted runners.
                # Check the page body directly with a timeout that accommodates it.
                $response = Invoke-WebRequest -Uri $url -Method Get -MaximumRedirection 8 -TimeoutSec 60 -SkipHttpErrorCheck -UserAgent 'c64-ctx-source-audit'
                [pscustomobject]@{ Url = $url; Status = [int]$response.StatusCode; Error = '' }
            }
            else {
                $response = Invoke-WebRequest -Uri $url -Method Head -MaximumRedirection 8 -TimeoutSec 20 -SkipHttpErrorCheck -UserAgent 'c64-ctx-source-audit'
                if ([int]$response.StatusCode -eq 405) { throw 'HEAD not supported' }
                [pscustomobject]@{ Url = $url; Status = [int]$response.StatusCode; Error = '' }
            }
        }
        catch {
            try {
                $response = Invoke-WebRequest -Uri $url -Method Get -MaximumRedirection 8 -TimeoutSec 20 -SkipHttpErrorCheck -UserAgent 'c64-ctx-source-audit'
                [pscustomobject]@{ Url = $url; Status = [int]$response.StatusCode; Error = '' }
            }
            catch {
                [pscustomobject]@{ Url = $url; Status = 0; Error = $_.Exception.Message }
            }
        }
    } -ThrottleLimit 16

    foreach ($result in $urlResults) {
        if (-not [string]::IsNullOrWhiteSpace($result.Error)) {
            Add-AuditError "external URL failed: $($result.Url) ($($result.Error))"
        }
        elseif ($result.Status -ge 400) {
            Add-AuditError "external URL returned HTTP $($result.Status): $($result.Url)"
        }
    }
}

if ($warnings.Count -gt 0) {
    Write-Host 'Warnings:' -ForegroundColor Yellow
    $warnings | ForEach-Object { Write-Host "  - $_" -ForegroundColor Yellow }
}

if ($errors.Count -gt 0) {
    Write-Host "Audit failed with $($errors.Count) error(s):" -ForegroundColor Red
    $errors | ForEach-Object { Write-Host "  - $_" -ForegroundColor Red }
    exit 1
}

Write-Host "Audit passed: $($markdownFiles.Count) Markdown files, $($externalUrls.Count) external URLs indexed."
