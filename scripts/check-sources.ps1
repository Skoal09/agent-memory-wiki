$ErrorActionPreference = "Stop"
$utf8 = [System.Text.Encoding]::UTF8
$root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$srcPath = Join-Path $root "topic-agent-memory\sources.md"

Write-Output "=== Gate 1: check-sources.ps1 ==="
if (-not (Test-Path $srcPath)) {
    Write-Output "FAIL: Missing topic-agent-memory/sources.md"
    exit 1
}

$text = [System.IO.File]::ReadAllText($srcPath, $utf8)
$wikiMatches = [regex]::Matches($text, 'wiki/[a-z0-9/_-]+\.md')
$uniqueWiki = $wikiMatches | ForEach-Object { $_.Value } | Sort-Object -Unique

$missing = @()
$paperCount = 0
foreach ($rel in $uniqueWiki) {
    $full = Join-Path $root ($rel.Replace('/', '\'))
    if (-not (Test-Path $full)) {
        $missing += $rel
    } elseif ($rel -like 'wiki/papers/*') {
        $paperCount++
    }
}

Write-Output "Referenced unique Wiki files: $($uniqueWiki.Count) (papers: $paperCount)"
if ($missing.Count -gt 0) {
    Write-Output "FAIL: Non-existent Wiki path(s): $($missing -join ', ')"
    exit 1
}
if ($uniqueWiki.Count -lt 3) {
    Write-Output "FAIL: Fewer than 3 relevant Wiki pages ($($uniqueWiki.Count)) - stopping per brake rule."
    exit 1
}
if ($paperCount -lt 5) {
    Write-Output "FAIL: Fewer than 5 papers covered ($paperCount) - minimum 5 required."
    exit 1
}

Write-Output "PASS: Gate 1 coverage check passed ($($uniqueWiki.Count) Wiki pages, $paperCount papers)."
exit 0
