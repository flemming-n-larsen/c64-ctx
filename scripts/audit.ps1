param(
    [switch]$CheckExternal
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path $PSScriptRoot -Parent
. (Join-Path $PSScriptRoot 'lib/markdown.ps1')
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
# Generated routing artifacts link every page by construction. Their links MUST
# NOT count toward reachability, or the orphan check below becomes vacuous: it
# has to keep measuring hand-authored and domain-index reachability.
$generatedRoutingFiles = @('ROUTE.md', 'SYMBOLS.md')
$errors = [System.Collections.Generic.List[string]]::new()
$warnings = [System.Collections.Generic.List[string]]::new()
$linkedFiles = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
$externalUrls = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)

function Add-AuditError([string]$message) {
    $errors.Add($message)
}


$markdownFiles = Get-CorpusMarkdownFiles $repoRoot

foreach ($file in $markdownFiles) {
    $relative = [IO.Path]::GetRelativePath($repoRoot, $file.FullName).Replace('\', '/')
    $content = Get-Content -LiteralPath $file.FullName -Raw
    if ($null -eq $content) { $content = '' }
    $scanContent = Get-ContentWithoutFences $content

    if ($relative -notin @('README.md', 'ATTRIBUTION.md', 'PLAN.md')) {
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

            # summary and keywords drive the generated routing layer, so a page
            # missing either is unreachable by the one-hop search path.
            $summary = Get-FrontMatterString $metadata 'summary'
            if ([string]::IsNullOrWhiteSpace($summary)) {
                Add-AuditError "${relative}: reference is missing front-matter summary"
            }
            elseif ($summary.Length -gt 100) {
                Add-AuditError "${relative}: summary is $($summary.Length) chars, limit is 100"
            }
            elseif ($summary -match '\]\(') {
                Add-AuditError "${relative}: summary MUST NOT contain a Markdown link"
            }

            if (-not $metadata.ContainsKey('keywords')) {
                Add-AuditError "${relative}: reference is missing front-matter keywords"
            }
            else {
                $rawKeywords = Get-FrontMatterString $metadata 'keywords'
                if (-not ($rawKeywords.StartsWith('[') -and $rawKeywords.EndsWith(']'))) {
                    # The front-matter parser reads line by line, so a YAML block
                    # list would silently produce zero keywords.
                    Add-AuditError "${relative}: keywords MUST use flow style [a, b, c]"
                }
                else {
                    $keywords = Get-FrontMatterList $metadata 'keywords'
                    if ($keywords.Count -lt 2 -or $keywords.Count -gt 8) {
                        Add-AuditError "${relative}: keywords has $($keywords.Count) entries, allowed range is 2-8"
                    }
                    foreach ($keyword in $keywords) {
                        if ($keyword.Length -gt 30) {
                            Add-AuditError "${relative}: keyword '$keyword' is over 30 chars"
                        }
                    }
                }
            }
        }

        if ($file.Name -eq 'INDEX.md' -and ($metadata.ContainsKey('summary') -or $metadata.ContainsKey('keywords'))) {
            Add-AuditError "${relative}: index MUST NOT declare summary or keywords; they belong on leaf pages"
        }

        if ($metadata.ContainsKey('source') -and $metadata['source'] -notin $allowedSources) {
            Add-AuditError "${relative}: unknown source identifier '$($metadata['source'])'"
        }
    }

    if ($scanContent -match '(?m)^\|[^\r\n]*\|\s*planned(?: seed)?\s*\|') {
        Add-AuditError "${relative}: stale planned coverage status"
    }

    # These tables restated their sibling ## routes and ## related rows; the
    # rule stops them growing back.
    if ($scanContent -match '(?m)^## source-coverage\s*$') {
        Add-AuditError "${relative}: ## source-coverage is retired; routing lives in ## routes and the generated ## pages block"
    }

    # Links inside a generated block are produced from front matter, so they
    # prove nothing about hand-authored reachability. Their spans are recorded
    # here and excluded from $linkedFiles below, while still being validated.
    $generatedSpans = foreach ($block in [regex]::Matches($scanContent, '(?s)<!-- GENERATED:routes -->.*?<!-- /GENERATED:routes -->')) {
        @{ Start = $block.Index; End = $block.Index + $block.Length }
    }

    foreach ($match in [regex]::Matches($scanContent, '(?<!\!)\[[^\]]+\]\(([^)]+)\)')) {
        $target = $match.Groups[1].Value.Trim()
        $inGeneratedBlock = $false
        foreach ($span in $generatedSpans) {
            if ($match.Index -ge $span.Start -and $match.Index -lt $span.End) { $inGeneratedBlock = $true; break }
        }
        if ($target -match '^(https?://|mailto:|#)') { continue }
        $pathPart = [uri]::UnescapeDataString(($target -split '#')[0])
        if ([string]::IsNullOrWhiteSpace($pathPart)) { continue }
        $resolved = [IO.Path]::GetFullPath((Join-Path $file.DirectoryName $pathPart))
        if (-not (Test-Path -LiteralPath $resolved)) {
            Add-AuditError "${relative}: broken local link '$target'"
            continue
        }
        if ($relative -notin $generatedRoutingFiles -and -not $inGeneratedBlock) {
            [void]$linkedFiles.Add($resolved)
        }
    }

    foreach ($match in [regex]::Matches($scanContent, 'https?://[^\s)>]+')) {
        $url = ($match.Value -split '\]\(')[0].TrimEnd('.', ',', ';')
        [void]$externalUrls.Add($url)
    }
}

foreach ($file in $markdownFiles) {
    $relative = [IO.Path]::GetRelativePath($repoRoot, $file.FullName).Replace('\', '/')
    if ($file.Name -in @('INDEX.md', 'README.md', 'AGENTS.md', 'STYLE.md', 'ATTRIBUTION.md', 'PLAN.md')) { continue }
    if ($relative -in $orphanAllowList) { continue }
    if (-not $linkedFiles.Contains($file.FullName)) {
        Add-AuditError "${relative}: factual page has no inbound local link"
    }
}

# Every reference page MUST appear exactly once in ROUTE.md. This catches
# generator bugs that would silently drop a page out of the search path.
$routePath = Join-Path $repoRoot 'ROUTE.md'
if (Test-Path -LiteralPath $routePath) {
    $routeContent = Get-Content -LiteralPath $routePath -Raw
    foreach ($file in $markdownFiles) {
        $relative = [IO.Path]::GetRelativePath($repoRoot, $file.FullName).Replace('\', '/')
        if ($file.Name -eq 'INDEX.md' -or $relative -in @('README.md', 'AGENTS.md', 'STYLE.md', 'ATTRIBUTION.md', 'PLAN.md', 'ROUTE.md', 'SYMBOLS.md')) { continue }
        $occurrences = ([regex]::Matches($routeContent, '\(' + [regex]::Escape($relative) + '\)')).Count
        if ($occurrences -ne 1) {
            Add-AuditError "${relative}: appears $occurrences times in ROUTE.md, expected exactly 1"
        }
    }
}
else {
    Add-AuditError 'ROUTE.md: missing; run scripts/generate-routes.ps1'
}

# The drift check is what makes the generated layer trustworthy: if the
# committed artifacts do not match what the current front matter produces,
# the build fails rather than serving a stale index.
& (Join-Path $PSScriptRoot 'generate-routes.ps1') -Check *> $null
if ($LASTEXITCODE -ne 0) {
    Add-AuditError 'generated routing layer is stale; run scripts/generate-routes.ps1'
}

if ($CheckExternal) {
    Write-Host "Checking $($externalUrls.Count) external URLs..."
    $urlResults = $externalUrls | ForEach-Object -Parallel {
        $url = $_

        # Hosts that answer slowly or not at all to HEAD from hosted runners.
        $slowHost = $url -match '^https://kodiak64\.co\.uk/'
        $timeoutSec = if ($slowHost) { 60 } else { 20 }
        $attempts = 3
        $result = $null

        for ($attempt = 1; $attempt -le $attempts; $attempt++) {
            try {
                if ($url -match '^https://codebase64\.net/') {
                    $response = Invoke-WebRequest -Uri $url -Method Get -MaximumRedirection 8 -TimeoutSec $timeoutSec -SkipHttpErrorCheck -UserAgent 'c64-ctx-source-audit'
                    $missingTopic = $response.Content -match '(?i)this topic does not exist|topic does not exist yet|page does not exist'
                    $result = [pscustomobject]@{ Url = $url; Status = [int]$response.StatusCode; Error = $(if ($missingTopic) { 'DokuWiki topic does not exist' } else { '' }) }
                }
                elseif ($slowHost) {
                    # Check the page body directly with a timeout that accommodates it.
                    $response = Invoke-WebRequest -Uri $url -Method Get -MaximumRedirection 8 -TimeoutSec $timeoutSec -SkipHttpErrorCheck -UserAgent 'c64-ctx-source-audit'
                    $result = [pscustomobject]@{ Url = $url; Status = [int]$response.StatusCode; Error = '' }
                }
                else {
                    $response = Invoke-WebRequest -Uri $url -Method Head -MaximumRedirection 8 -TimeoutSec $timeoutSec -SkipHttpErrorCheck -UserAgent 'c64-ctx-source-audit'
                    if ([int]$response.StatusCode -eq 405) { throw 'HEAD not supported' }
                    $result = [pscustomobject]@{ Url = $url; Status = [int]$response.StatusCode; Error = '' }
                }
            }
            catch {
                try {
                    $response = Invoke-WebRequest -Uri $url -Method Get -MaximumRedirection 8 -TimeoutSec $timeoutSec -SkipHttpErrorCheck -UserAgent 'c64-ctx-source-audit'
                    $result = [pscustomobject]@{ Url = $url; Status = [int]$response.StatusCode; Error = '' }
                }
                catch {
                    $result = [pscustomobject]@{ Url = $url; Status = 0; Error = $_.Exception.Message }
                }
            }

            # Transient failures (timeouts, resets, 5xx) are worth another try;
            # a clean 4xx is a real broken link and should not be retried.
            $transient = $result.Status -eq 0 -or $result.Status -ge 500
            if (-not $transient) { break }
            if ($attempt -lt $attempts) { Start-Sleep -Seconds (2 * $attempt) }
        }

        $result
    } -ThrottleLimit 16

    foreach ($result in $urlResults) {
        if (-not [string]::IsNullOrWhiteSpace($result.Error)) {
            # A host that cannot be reached after retries makes availability
            # unknowable; it is not evidence that the documented URL is broken.
            # Preserve hard failures for responses that were actually received.
            if ($result.Status -eq 0) {
                $warnings.Add("external URL could not be reached: $($result.Url) ($($result.Error))")
            }
            else {
                Add-AuditError "external URL failed: $($result.Url) ($($result.Error))"
            }
        }
        elseif ($result.Status -ge 500) {
            # A server-side failure is likewise an availability issue.  Keep it
            # visible without treating a temporary upstream outage as a bad link.
            $warnings.Add("external URL returned transient HTTP $($result.Status): $($result.Url)")
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
