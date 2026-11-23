$ErrorActionPreference = "Stop"
$utf8 = [System.Text.Encoding]::UTF8
$utf8NoBom = New-Object System.Text.UTF8Encoding $false
$root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$outPath = Join-Path $root "assets\wiki-bundle.js"

$files = New-Object System.Collections.Generic.List[string]
$files.Add("wiki/index.md")

foreach ($sub in @("papers", "concepts", "entities", "syntheses")) {
    $dir = Join-Path $root "wiki\$sub"
    if (Test-Path $dir) {
        Get-ChildItem -Path $dir -Filter "*.md" | Sort-Object Name | ForEach-Object {
            $rel = $_.FullName.Substring($root.Length + 1).Replace('\', '/')
            $files.Add($rel)
        }
    }
}

$map = [ordered]@{}
foreach ($rel in $files) {
    $full = Join-Path $root ($rel.Replace('/', '\'))
    if (Test-Path $full) {
        $map[$rel] = [System.IO.File]::ReadAllText($full, $utf8)
    }
}

$json = $map | ConvertTo-Json -Depth 4
$js = "// Auto-generated static bundle for offline & GitHub Pages Wiki viewing`nwindow.WIKI_FILES = $json;`n"
[System.IO.File]::WriteAllText($outPath, $js, $utf8NoBom)
Write-Output "Bundled $($map.Count) Wiki Markdown files into assets/wiki-bundle.js ($((Get-Item $outPath).Length) bytes)."
