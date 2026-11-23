$ErrorActionPreference = "Stop"
$utf8 = [System.Text.Encoding]::UTF8
$root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$deckPath = Join-Path $root "deck.html"
$draftsDir = Join-Path $root "topic-agent-memory\drafts"

Write-Output "=== Gate 4: check-deck.ps1 ==="
if (-not (Test-Path $deckPath)) {
    Write-Output "FAIL: Missing deck.html at repo root."
    exit 1
}

$sizeBytes = (Get-Item $deckPath).Length
if ($sizeBytes -gt 5MB) {
    Write-Output "FAIL: deck.html exceeds 5 MB ($sizeBytes bytes)."
    exit 1
}

$html = [System.IO.File]::ReadAllText($deckPath, $utf8)
$errors = New-Object System.Collections.Generic.List[string]

# 1. Placeholder & forbidden token check
if ($html -match '\bTODO\b|\bTBD\b|\{\{') {
    $errors.Add("Unresolved template placeholder (TODO/TBD/{{) found in deck.html.")
}

# 2. Keyboard navigation check
if ($html -notmatch 'ArrowRight' -or $html -notmatch 'ArrowLeft') {
    $errors.Add("Missing keyboard navigation handlers (ArrowLeft/ArrowRight) in deck.html.")
}

# 3. Slide count matches drafts
$draftCount = (Get-ChildItem -Path $draftsDir -Filter "slide-*.md").Count
$slideMatches = [regex]::Matches($html, '<section\s+class="slide[^"]*"[^>]*>([\s\S]*?)</section>')
Write-Output "Slides in deck.html: $($slideMatches.Count) (drafts: $draftCount, file size: $sizeBytes bytes)"
if ($slideMatches.Count -ne $draftCount) {
    $errors.Add("Slide count mismatch: deck.html has $($slideMatches.Count), drafts/ has $draftCount.")
}
if ($slideMatches.Count -lt 8 -or $slideMatches.Count -gt 15) {
    $errors.Add("Slide count ($($slideMatches.Count)) outside 8-15 range.")
}

# 4. Per-slide source attribute, wiki-viewer link, and rendered text density check
$sIdx = 1
foreach ($sm in $slideMatches) {
    $fullTag = $sm.Value
    $inner = $sm.Groups[1].Value

    $srcAttr = [regex]::Match($fullTag, 'data-wiki-source="([^"]+)"')
    if (-not $srcAttr.Success) {
        $errors.Add("Slide $sIdx missing data-wiki-source attribute.")
    } else {
        $paths = $srcAttr.Groups[1].Value -split ','
        foreach ($p in $paths) {
            $trimmed = $p.Trim()
            if (-not (Test-Path (Join-Path $root ($trimmed.Replace('/', '\'))))) {
                $errors.Add("Slide $sIdx references missing Wiki file: $trimmed")
            }
        }
    }

    if ($inner -notmatch 'wiki-viewer\.html\?file=wiki/') {
        $errors.Add("Slide $sIdx missing clickable wiki-viewer.html?file=wiki/... footer link.")
    }

    # Strip svg, script, style, slide-footer, and HTML tags to measure main visible text density
    $mainOnly = [regex]::Replace($inner, '<svg[\s\S]*?</svg>', ' ', 'IgnoreCase')
    $mainOnly = [regex]::Replace($mainOnly, '<footer[\s\S]*?</footer>', ' ', 'IgnoreCase')
    $mainOnly = [regex]::Replace($mainOnly, '<[^>]+>', ' ')
    $mainOnly = [System.Net.WebUtility]::HtmlDecode($mainOnly)
    $compact = [regex]::Replace($mainOnly, '\s+', '')
    if ($compact.Length -gt 380) {
        $errors.Add("Slide $sIdx rendered visible content too dense ($($compact.Length) chars > 380) - risk of vertical overflow.")
    }
    $sIdx++
}

if ($errors.Count -gt 0) {
    Write-Output "FAIL: Found $($errors.Count) deck verification error(s):"
    foreach ($e in $errors) { Write-Output "  - $e" }
    exit 1
} else {
    Write-Output "PASS: Gate 4 deck.html check passed ($($slideMatches.Count) slides, all Wiki sources verified, no overflow risk)."
    exit 0
}
