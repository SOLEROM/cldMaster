# Focus AI — Claude Code Manager Skills Bundle Installer (Windows PowerShell)
$SkillsDir = Join-Path $PSScriptRoot "skills"
$Target    = Join-Path $env:USERPROFILE ".claude\skills"
$Count     = 0
$Errors    = 0

Write-Host ""
Write-Host "=== Focus AI - Manager Skills Installer ===" -ForegroundColor Cyan
Write-Host ""

New-Item -ItemType Directory -Force -Path $Target | Out-Null

foreach ($categoryDir in Get-ChildItem -Path $SkillsDir -Directory) {
  foreach ($skillFile in Get-ChildItem -Path $categoryDir.FullName -Filter "skill-*.md") {
    $skillName = $skillFile.BaseName -replace '^skill-', ''
    $dest = Join-Path $Target $skillName
    New-Item -ItemType Directory -Force -Path $dest | Out-Null
    Copy-Item -Path $skillFile.FullName -Destination (Join-Path $dest "SKILL.md") -Force
    Write-Host "  [OK] /$skillName" -ForegroundColor Green
    $Count++
  }
}

Write-Host ""
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "Installed $Count skills to $Target" -ForegroundColor Green
if ($Errors -gt 0) {
  Write-Host "$Errors errors — check output above" -ForegroundColor Yellow
}
Write-Host ""
Write-Host "Test: open any folder, run 'claude', type /strategic-plan"
Write-Host ""
