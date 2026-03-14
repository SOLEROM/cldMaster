# update-digido.ps1 — Update DiGido Skills & Workflows (Windows)
# Copies files from source INTO existing folders, OVERWRITING existing files.
# Use this after install-digido.ps1 when folders were copied (not junctions).
#
# Usage:
#   .\update-digido.ps1

# ============================================================================
# Configuration
# ============================================================================

$DiGidoHome = $PSScriptRoot
$UserHome = $env:USERPROFILE

$Targets = @(
    @{
        Name   = "Antigravity Skills"
        Dest   = Join-Path $UserHome ".gemini\antigravity\skills"
        Source = Join-Path $DiGidoHome ".agent\skills"
    },
    @{
        Name   = "Antigravity Workflows"
        Dest   = Join-Path $UserHome ".gemini\antigravity\global_workflows"
        Source = Join-Path $DiGidoHome ".agent\workflows"
    },
    @{
        Name   = "Claude Code Skills"
        Dest   = Join-Path $UserHome ".claude\skills"
        Source = Join-Path $DiGidoHome ".agent\skills"
    },
    @{
        Name   = "Claude Code Commands"
        Dest   = Join-Path $UserHome ".claude\commands"
        Source = Join-Path $DiGidoHome ".agent\workflows"
    }
)

function Test-IsJunction {
    param([string]$Path)
    if (-not (Test-Path $Path)) { return $false }
    $item = Get-Item $Path -Force -ErrorAction SilentlyContinue
    return ($item.Attributes -band [System.IO.FileAttributes]::ReparsePoint)
}

# ============================================================================
# Update
# ============================================================================

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  DiGido Skills — Update" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  This will overwrite all DiGido files that have the same name" -ForegroundColor White
Write-Host "  in the target folders with the latest versions from source." -ForegroundColor White
Write-Host "  Your own custom files (different names) will NOT be touched." -ForegroundColor White
Write-Host ""
$answer = Read-Host "  Proceed? (Y/N)"
if ($answer -notmatch '^[Yy]') {
    Write-Host ""
    Write-Host "  Update cancelled." -ForegroundColor Yellow
    Write-Host ""
    exit 0
}
Write-Host ""

$updatedTotal = 0

foreach ($target in $Targets) {
    # Skip if destination doesn't exist
    if (-not (Test-Path $target.Dest)) {
        Write-Host "  SKIP: $($target.Name) - destination not found" -ForegroundColor Yellow
        Write-Host "        Run .\install-digido.ps1 first." -ForegroundColor Gray
        Write-Host ""
        continue
    }

    # Skip junctions — they auto-update
    if (Test-IsJunction $target.Dest) {
        Write-Host "  OK: $($target.Name) - junction (auto-updates, nothing to do)" -ForegroundColor Green
        Write-Host ""
        continue
    }

    # Skip if source doesn't exist
    if (-not (Test-Path $target.Source)) {
        Write-Host "  SKIP: $($target.Name) - source not found" -ForegroundColor Yellow
        Write-Host ""
        continue
    }

    # Copy files, overwriting existing ones from source
    $updated = 0
    $added = 0
    $sourceFiles = Get-ChildItem -Path $target.Source -File
    foreach ($file in $sourceFiles) {
        $destFile = Join-Path $target.Dest $file.Name
        if (Test-Path $destFile) {
            $updated++
        } else {
            $added++
        }
        Copy-Item -Path $file.FullName -Destination $destFile -Force
    }
    Write-Host "  UPDATED: $($target.Name)" -ForegroundColor Green
    Write-Host "           Files overwritten: $updated | New files added: $added" -ForegroundColor Gray
    $updatedTotal += ($updated + $added)
    Write-Host ""
}

# Summary
Write-Host "========================================" -ForegroundColor Cyan
if ($updatedTotal -gt 0) {
    Write-Host "  Update complete! ($updatedTotal files processed)" -ForegroundColor Green
} else {
    Write-Host "  Nothing to update." -ForegroundColor Yellow
}
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
