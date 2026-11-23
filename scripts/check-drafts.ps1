$ErrorActionPreference = "Stop"
$utf8 = [System.Text.Encoding]::UTF8
$root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$draftsDir = Join-Path $root "topic-agent-memory\drafts"
$cardsDir = Join-Path $root "topic-agent-memory\cards"

Write-Output "=== Gate 3: check-drafts.ps1 ==="
$draftFiles = Get-ChildItem -Path $draftsDir -Filter "slide-*.md" | Sort-Object Name
if ($draftFiles.Count -lt 8 -or $draftFiles.Count -gt 15) {
    Write-Output "FAIL: Expected 8-15 draft files, found $($draftFiles.Count)"
    exit 1
}

# Build combined corpus of evidence cards + syntheses for stat verification
$cardsText = ""
Get-ChildItem -Path $cardsDir -Filter "*.md" | ForEach-Object {
    $cardsText += "`n" + [System.IO.File]::ReadAllText($_.FullName, $utf8)
}

$errors = New-Object System.Collections.Generic.List[string]
$maxVisibleChars = 240
$maxBullets = 5

foreach ($df in $draftFiles) {
    $raw = [System.IO.File]::ReadAllText($df.FullName, $utf8)
    $lines = $raw -split "`r?`n"

    # 1. Check metadata: 出處 line & valid wiki paths
    $sourceLine = ($lines | Where-Object { $_ -match '^\-\s*\*\*出處\*\*：|^出處：' }) -join " "
    if ([string]::IsNullOrWhiteSpace($sourceLine)) {
        $errors.Add("$($df.Name): Missing '出處：' citation line.")
    } else {
        $wPaths = [regex]::Matches($sourceLine, 'wiki/[a-z0-9/_-]+\.md') | ForEach-Object { $_.Value } | Sort-Object -Unique
        if ($wPaths.Count -eq 0) {
            $errors.Add("$($df.Name): No wiki/... path found on 出處 line.")
        } else {
            foreach ($wp in $wPaths) {
                if (-not (Test-Path (Join-Path $root ($wp.Replace('/', '\'))))) {
                    $errors.Add("$($df.Name): Cited Wiki file does not exist: $wp")
                }
            }
        }
        if ($sourceLine -notmatch '\[[^\]]*(?:Sec\.|Table|Fig\.|Abstract|綜合|導覽)[^\]]*\]') {
            $errors.Add("$($df.Name): Missing section-level citation bracket [Paper Year, Sec. X].")
        }
    }

    # 2. Extract body lines (exclude metadata lines, markdown headings, fences, blank lines)
    $bodyLines = New-Object System.Collections.Generic.List[string]
    $bulletCount = 0
    $inBody = $false
    foreach ($ln in $lines) {
        if ($ln -match '^---$') {
            $inBody = $true
            continue
        }
        if (-not $inBody) { continue }
        if ($ln -match '^\s*$') { continue }
        if ($ln -match '^\s*[-*]\s+') { $bulletCount++ }
        if ($ln -match '^\s*\d+\.\s+') { $bulletCount++ }
        $clean = $ln -replace '`', '' -replace '\*\*', '' -replace '\[([^\]]+)\]\([^)]+\)', '$1' -replace '^\s*#+\s*', '' -replace '^\s*[-*>\d\.]+\s*', '' -replace '\s+', ''
        $bodyLines.Add($clean)
    }

    $bodyJoined = ($bodyLines -join "")
    # Exclude bracketed citation tags when measuring reader-facing body copy budget
    $bodyNoCites = [regex]::Replace($bodyJoined, '\[[^\]]+\]', '')
    $charCount = $bodyNoCites.Length

    if ($bulletCount -gt $maxBullets) {
        $errors.Add("$($df.Name): Too many bullet points ($bulletCount > $maxBullets) - risk of slide overflow.")
    }
    if ($charCount -gt $maxVisibleChars) {
        $errors.Add("$($df.Name): Body text too dense ($charCount chars > budget $maxVisibleChars chars) - risk of slide overflow.")
    }

    # 3. Verify every percentage / multiplier stat in body appears in evidence cards
    $bodyFull = ($lines | Select-Object -Skip 1) -join "`n"
    $statMatches = [regex]::Matches($bodyFull, '(\d+(?:\.\d+)?)\s*(%|倍|×)')
    foreach ($sm in $statMatches) {
        $num = $sm.Groups[1].Value
        # Allow basic percentages/numbers present in cardsText
        if ($cardsText -notmatch [regex]::Escape($num)) {
            $errors.Add("$($df.Name): Statistic '$($sm.Value)' (number $num) not found in topic-agent-memory/cards/*.md.")
        }
    }
}

Write-Output "Checked $($draftFiles.Count) draft slide(s) (budget: <= $maxVisibleChars chars, <= $maxBullets bullets)."
if ($errors.Count -gt 0) {
    Write-Output "FAIL: Found $($errors.Count) draft gate error(s):"
    foreach ($e in $errors) { Write-Output "  - $e" }
    exit 1
} else {
    Write-Output "PASS: Gate 3 drafts check passed (all citations valid, density within budget, all stats grounded in cards)."
    exit 0
}
