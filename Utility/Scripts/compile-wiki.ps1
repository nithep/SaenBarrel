param(
    [string]$VaultPath = "D:\SaenBarrel"
)

$ErrorActionPreference = "Stop"

$rawPath = Join-Path $VaultPath "00_Raw"
$conceptPath = Join-Path $VaultPath "01_Wiki\Concepts"
$mocPath = Join-Path $VaultPath "01_Wiki\MOCs"

New-Item -ItemType Directory -Force -Path $rawPath, $conceptPath, $mocPath | Out-Null

$today = Get-Date -Format "yyyy-MM-dd"
$rawFiles = Get-ChildItem -LiteralPath $rawPath -Filter "*.md" -File

foreach ($file in $rawFiles) {
    $title = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
    $target = Join-Path $conceptPath "$title.md"
    $sourceValue = "00_Raw/$($file.Name)"

    $sourceAlreadyCompiled = Get-ChildItem -LiteralPath $conceptPath -Filter "*.md" -File |
        Where-Object {
            (Get-Content -LiteralPath $_.FullName -Raw -Encoding UTF8) -match [regex]::Escape("source: `"$sourceValue`"")
        } |
        Select-Object -First 1

    if ($sourceAlreadyCompiled) {
        Write-Host "skip compiled source: $($file.Name) -> $($sourceAlreadyCompiled.Name)"
        continue
    }

    if (Test-Path -LiteralPath $target) {
        Write-Host "skip existing concept: $title"
        continue
    }

    $body = Get-Content -LiteralPath $file.FullName -Raw -Encoding UTF8
    $content = @"
---
title: "$title"
created: $today
updated: $today
type: concept
status: draft
tags: [compiled]
source: "00_Raw/$($file.Name)"
related: []
---

# $title

## สรุปแก่น
TODO: ให้ LLM หรือ Vault Manager กลั่นสรุปจาก Raw นี้

## รายละเอียดจาก Raw
$body

## งานต่อไป
- กลั่นบทความให้เหลือหนึ่งแนวคิดหลัก
- เพิ่ม wikilink และ MOC ที่เกี่ยวข้อง
"@

    Set-Content -LiteralPath $target -Value $content -Encoding UTF8
    Write-Host "created concept: $title"
}

$indexPath = Join-Path $mocPath "Auto Index.md"
$conceptFiles = Get-ChildItem -LiteralPath $conceptPath -Filter "*.md" -File | Sort-Object Name
$links = $conceptFiles | ForEach-Object { "- [[$([System.IO.Path]::GetFileNameWithoutExtension($_.Name))]]" }

$index = @"
---
title: "Auto Index"
created: $today
updated: $today
type: moc
status: active
tags: [moc, auto-index]
source: "Utility/Scripts/compile-wiki.ps1"
---

# Auto Index

## Concepts
$($links -join "`r`n")
"@

Set-Content -LiteralPath $indexPath -Value $index -Encoding UTF8
Write-Host "updated index: $indexPath"
