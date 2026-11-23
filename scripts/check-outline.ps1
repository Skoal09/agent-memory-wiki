$ErrorActionPreference = "Stop"
$utf8 = [System.Text.Encoding]::UTF8
$root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$outlinePath = Join-Path $root "topic-agent-memory\outline.md"

Write-Output "=== Gate 2: check-outline.ps1 ==="
if (-not (Test-Path $outlinePath)) {
    Write-Output "FAIL: Missing topic-agent-memory/outline.md"
    exit 1
}

$text = [System.IO.File]::ReadAllText($outlinePath, $utf8)
$slideSections = [regex]::Split($text, '(?m)^##\s+Slide\s+\d+')
# First chunk is header before Slide 01
$slides = $slideSections | Select-Object -Skip 1
Write-Output "Detected slides in outline: $($slides.Count)"

$errors = New-Object System.Collections.Generic.List[string]
if ($slides.Count -lt 8 -or $slides.Count -gt 15) {
    $errors.Add("Slide count ($($slides.Count)) outside allowed range 8-15.")
}

$idx = 1
foreach ($s in $slides) {
    $wikiRefs = [regex]::Matches($s, 'wiki/[a-z0-9/_-]+\.md') | ForEach-Object { $_.Value } | Sort-Object -Unique
    if ($wikiRefs.Count -eq 0) {
        $errors.Add("Slide $idx has no wiki/... source path.")
    } else {
        foreach ($wr in $wikiRefs) {
            if (-not (Test-Path (Join-Path $root ($wr.Replace('/', '\'))))) {
                $errors.Add("Slide $idx references missing file: $wr")
            }
        }
    }
    if ($s -notmatch 'card-0[1-6]') {
        $errors.Add("Slide $idx does not map to any evidence card (card-01..card-06).")
    }
    $idx++
}

# Verify all 6 cards appear across the outline
for ($c = 1; $c -le 6; $c++) {
    $cid = "card-0$c"
    if ($text -notmatch $cid) {
        $errors.Add("Evidence card $cid is not covered in outline.md.")
    }
}

if ($errors.Count -gt 0) {
    Write-Output "FAIL: $($errors.Count) outline issue(s):"
    foreach ($e in $errors) { Write-Output "  - $e" }
    exit 1
}

Write-Output "PASS: Gate 2 outline check passed ($($slides.Count) slides, all 6 evidence cards covered)."
exit 0
