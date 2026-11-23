$ErrorActionPreference = "Stop"
$utf8 = [System.Text.Encoding]::UTF8
$root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$errors = New-Object System.Collections.Generic.List[string]

Write-Output "=== Final Site & Privacy Check: check-site.ps1 ==="

# 1. Required root GitHub Pages files
$requiredFiles = @("index.html", "deck.html", "wiki-viewer.html", "README.md", "AGENTS.md", "assets\wiki-bundle.js")
foreach ($rf in $requiredFiles) {
    $full = Join-Path $root $rf
    if (-not (Test-Path $full)) {
        $errors.Add("Missing required site file: $rf")
    } elseif ((Get-Item $full).Length -gt 25MB) {
        $errors.Add("File exceeds GitHub web upload limit (25 MB): $rf")
    }
}

# 2. Check HTML internal href/src targets exist
$htmlFiles = @("index.html", "deck.html", "wiki-viewer.html")
$refRegex = [regex]'(?:href|src)="([^"#?]+)(?:[?#][^"]*)?"'
foreach ($hf in $htmlFiles) {
    $fullH = Join-Path $root $hf
    if (-not (Test-Path $fullH)) { continue }
    $content = [System.IO.File]::ReadAllText($fullH, $utf8)
    $htmlOnly = [regex]::Replace($content, '<script[\s\S]*?</script>', ' ', 'IgnoreCase')
    $htmlOnly = [regex]::Replace($htmlOnly, '<style[\s\S]*?</style>', ' ', 'IgnoreCase')
    foreach ($m in $refRegex.Matches($htmlOnly)) {
        $target = $m.Groups[1].Value.Trim()
        if ($target -match '^(https?://|mailto:|data:)' -or [string]::IsNullOrWhiteSpace($target)) { continue }
        $resolved = Join-Path $root ($target.Replace('/', '\'))
        if (-not (Test-Path $resolved)) {
            $errors.Add("Broken asset/page link in ${hf}: '$target'")
        }
    }
    if ($content -match '\bTODO\b|\bTBD\b|\{\{') {
        $errors.Add("Unresolved placeholder found in $hf")
    }
}

# 3. Check wiki-viewer.html supports ?file= query parameter and WIKI_FILES bundle
$wvPath = Join-Path $root "wiki-viewer.html"
if (Test-Path $wvPath) {
    $wvText = [System.IO.File]::ReadAllText($wvPath, $utf8)
    if ($wvText -notmatch 'WIKI_FILES' -or $wvText -notmatch 'URLSearchParams') {
        $errors.Add("wiki-viewer.html missing WIKI_FILES bundle support or URLSearchParams routing.")
    }
}

# 4. Generic Privacy & Secrets scan across entire repo (excluding .git)
$forbiddenPatterns = @(
    '[A-Za-z0-9._%+-]+@(?!example\.com)[A-Za-z0-9.-]+\.[A-Za-z]{2,}',
    'AIza[0-9A-Za-z_-]{20,}',
    'sk-[0-9A-Za-z]{20,}',
    'ghp_[0-9A-Za-z]{20,}'
)
Get-ChildItem -Path $root -Recurse -File | Where-Object {
    $_.FullName -notmatch '\\\.git\\' -and $_.Name -ne "check-site.ps1" -and $_.FullName -notmatch '\\raw\\'
} | ForEach-Object {
    $txt = [System.IO.File]::ReadAllText($_.FullName, $utf8)
    foreach ($pat in $forbiddenPatterns) {
        if ($txt -match $pat) {
            $rel = $_.FullName.Substring($root.Length + 1)
            $errors.Add("[Privacy/Secret] Matched sensitive pattern '$pat' in $rel")
        }
    }
}

# 5. GitHub Pages lowercase filename check across entire repo
Get-ChildItem -Path $root -Recurse | Where-Object { $_.FullName -notmatch '\\\.git\\' -and $_.FullName -notmatch '\\\.agents\\' } | ForEach-Object {
    if ($_.Name -notin @("AGENTS.md", "README.md", ".gitignore")) {
        if ($_.Name -notmatch '^[a-z0-9._-]+$') {
            $rel = $_.FullName.Substring($root.Length + 1)
            $errors.Add("[Filename] Invalid GitHub Pages name (must be lowercase a-z0-9._-): $rel")
        }
    }
}

if ($errors.Count -gt 0) {
    Write-Output "FAIL: Found $($errors.Count) site check error(s):"
    foreach ($e in $errors) { Write-Output "  - $e" }
    exit 1
} else {
    Write-Output "PASS: All GitHub Pages links, bundle, lowercase filenames, and privacy checks passed."
    exit 0
}
