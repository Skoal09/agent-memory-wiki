param(
    [switch]$RequireSynthesis
)

$ErrorActionPreference = "Stop"
$utf8 = [System.Text.Encoding]::UTF8
$root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$wikiDir = Join-Path $root "wiki"
$errors = New-Object System.Collections.Generic.List[string]
$warnings = New-Object System.Collections.Generic.List[string]

Write-Output "=== LLM Wiki Lint Check ==="
Write-Output "Root: $root"

# 1. GitHub Pages lowercase filename hygiene
$webDirs = @("raw", "wiki", "scripts", "assets", "topic-agent-memory")
foreach ($d in $webDirs) {
    $fullD = Join-Path $root $d
    if (-not (Test-Path $fullD)) { continue }
    Get-ChildItem -Path $fullD -Recurse | ForEach-Object {
        if ($_.Name -notmatch '^[a-z0-9._-]+$') {
            $errors.Add("[Filename] Non-lowercase/invalid GitHub Pages name: $($_.FullName.Substring($root.Length + 1))")
        }
    }
}
Get-ChildItem -Path $root -File | ForEach-Object {
    if ($_.Name -notin @("AGENTS.md", "README.md", ".gitignore")) {
        if ($_.Name -notmatch '^[a-z0-9._-]+$') {
            $errors.Add("[Filename] Root file violates lowercase naming: $($_.Name)")
        }
    }
}

# 2. Collect all wiki markdown files
$allWikiFiles = Get-ChildItem -Path $wikiDir -Recurse -Filter "*.md"
$contentDirs = @("papers", "concepts", "entities", "syntheses")
$contentFiles = @()
foreach ($cd in $contentDirs) {
    $p = Join-Path $wikiDir $cd
    if (Test-Path $p) {
        $contentFiles += Get-ChildItem -Path $p -Filter "*.md"
    }
}

# Track inbound links per content file (relative to wikiDir, normalized with '/')
$inboundFromIndex = @{}
$inboundFromOthers = @{}
foreach ($cf in $contentFiles) {
    $rel = $cf.FullName.Substring($wikiDir.Length + 1).Replace('\', '/')
    $inboundFromIndex[$rel] = 0
    $inboundFromOthers[$rel] = 0
}

$indexPath = Join-Path $wikiDir "index.md"
if (-not (Test-Path $indexPath)) {
    $errors.Add("[Structure] Missing wiki/index.md")
}
$logPath = Join-Path $wikiDir "log.md"
if (-not (Test-Path $logPath)) {
    $errors.Add("[Structure] Missing wiki/log.md")
}

# 3. Check broken internal links across all wiki/**/*.md
$linkRegex = [regex]'\[[^\]]+\]\(([^)#]+)(?:#[^)]+)?\)'
foreach ($wf in $allWikiFiles) {
    $text = [System.IO.File]::ReadAllText($wf.FullName, $utf8)
    $srcDir = $wf.DirectoryName
    $srcRelFromWiki = $wf.FullName.Substring($wikiDir.Length + 1).Replace('\', '/')
    $matches = $linkRegex.Matches($text)

    foreach ($m in $matches) {
        $targetRaw = $m.Groups[1].Value.Trim()
        if ($targetRaw -match '^(https?://|mailto:)' -or [string]::IsNullOrWhiteSpace($targetRaw)) { continue }

        $resolved = $null
        try {
            $resolvedObj = Resolve-Path -Path (Join-Path $srcDir $targetRaw) -ErrorAction Stop
            $resolved = $resolvedObj.Path
        } catch {
            $errors.Add("[Broken Link] In wiki/$srcRelFromWiki -> '$targetRaw' does not exist")
            continue
        }

        if ($resolved.StartsWith($wikiDir, [System.StringComparison]::OrdinalIgnoreCase)) {
            $targetRel = $resolved.Substring($wikiDir.Length + 1).Replace('\', '/')
            if ($inboundFromIndex.ContainsKey($targetRel)) {
                if ($srcRelFromWiki -eq "index.md") {
                    $inboundFromIndex[$targetRel]++
                } elseif ($srcRelFromWiki -ne $targetRel -and $srcRelFromWiki -ne "log.md") {
                    $inboundFromOthers[$targetRel]++
                }
            }
        }
    }
}

# 4. Orphan page check
foreach ($rel in $inboundFromIndex.Keys) {
    if ($inboundFromIndex[$rel] -eq 0) {
        $errors.Add("[Orphan] wiki/$rel is NOT linked from wiki/index.md")
    }
    if ($inboundFromOthers[$rel] -eq 0) {
        $errors.Add("[Orphan] wiki/$rel has NO inbound link from any other content page in wiki/")
    }
}

# 5. Paper citation hygiene check
$papersDir = Join-Path $wikiDir "papers"
if (Test-Path $papersDir) {
    $paperFiles = Get-ChildItem -Path $papersDir -Filter "*.md"
    $citeRegex = [regex]'\[[^\]]*(?:Sec\.|Abstract|Table|Fig\.|Conclusion|Introduction)[^\]]*\]'
    foreach ($pf in $paperFiles) {
        $pText = [System.IO.File]::ReadAllText($pf.FullName, $utf8)
        if ($pText -notmatch '發表出處') {
            $errors.Add("[Citation] wiki/papers/$($pf.Name) missing '發表出處' metadata")
        }
        if ($pText -notmatch '\.\./\.\./raw/[a-z0-9-]+\.md') {
            $errors.Add("[Citation] wiki/papers/$($pf.Name) missing link to ../../raw/<slug>.md")
        }
        $citeCount = $citeRegex.Matches($pText).Count
        if ($citeCount -lt 3) {
            $errors.Add("[Citation] wiki/papers/$($pf.Name) has only $citeCount section citations (minimum 3 required)")
        }
    }
}

# 6. Conflict marker check
$hasSynth = (Test-Path (Join-Path $wikiDir "syntheses")) -and ((Get-ChildItem -Path (Join-Path $wikiDir "syntheses") -Filter "*.md").Count -gt 0)
if ($RequireSynthesis -or $hasSynth) {
    $conflictHits = 0
    foreach ($wf in $allWikiFiles) {
        $t = [System.IO.File]::ReadAllText($wf.FullName, $utf8)
        if ($t -match '⚠️\s*觀點差異') { $conflictHits++ }
    }
    if ($conflictHits -eq 0) {
        $errors.Add("[Conflict] No '⚠️ 觀點差異' marker found across wiki/ concepts or syntheses")
    } else {
        Write-Output "Conflict markers verified in $conflictHits wiki file(s)."
    }
}

Write-Output "Checked $($allWikiFiles.Count) wiki files ($($contentFiles.Count) content pages)."
if ($errors.Count -gt 0) {
    Write-Output "FAIL: Found $($errors.Count) error(s):"
    foreach ($e in $errors) { Write-Output "  - $e" }
    exit 1
} else {
    Write-Output "PASS: 0 broken links, 0 orphans, all citation & naming rules satisfied."
    exit 0
}
