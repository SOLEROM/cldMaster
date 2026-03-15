# Focus AI — Claude Code Skills Bundle Installer (Windows PowerShell)
# Installs all 50 skills to %USERPROFILE%\.claude\skills\

$SkillsDir = Join-Path $PSScriptRoot "skills"
$Target    = Join-Path $env:USERPROFILE ".claude\skills"
$Count     = 0
$Errors    = 0

Write-Host ""
Write-Host "=== Focus AI - Claude Code Skills Installer ===" -ForegroundColor Cyan
Write-Host ""

# Ensure target exists
New-Item -ItemType Directory -Force -Path $Target | Out-Null

# Walk: skills/<category>/<skill-name>/skill-*.md
foreach ($categoryDir in Get-ChildItem -Path $SkillsDir -Directory) {
  foreach ($skillDir in Get-ChildItem -Path $categoryDir.FullName -Directory) {
    $skillName = $skillDir.Name
    $skillFile = Get-ChildItem -Path $skillDir.FullName -Filter "skill-*.md" | Select-Object -First 1
    if (-not $skillFile) {
      Write-Host "  [SKIP] $skillName — no skill file found" -ForegroundColor Yellow
      $Errors++
      continue
    }
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
Write-Host "Test: open a project, run 'claude', type /code-review"
Write-Host ""
