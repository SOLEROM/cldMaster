# install-digido.ps1 — Global DiGido Skills Installer for Windows
# Connects your digido-skills to Antigravity + Claude Code globally
#
# Usage:
#   .\install-digido.ps1              Install (connect skills globally)
#   .\install-digido.ps1 -Uninstall   Remove global connections

param(
    [switch]$Uninstall
)

# ============================================================================
# Configuration
# ============================================================================

$DiGidoHome = $PSScriptRoot
$UserHome = $env:USERPROFILE

# Target paths (the "brain" of each agent)
$Targets = @(
    @{
        Name        = "Antigravity Skills"
        Link        = Join-Path $UserHome ".gemini\antigravity\skills"
        Source      = Join-Path $DiGidoHome ".agent\skills"
        ParentDirs  = @(
            (Join-Path $UserHome ".gemini"),
            (Join-Path $UserHome ".gemini\antigravity")
        )
    },
    @{
        Name        = "Antigravity Workflows"
        Link        = Join-Path $UserHome ".gemini\antigravity\global_workflows"
        Source      = Join-Path $DiGidoHome ".agent\workflows"
        ParentDirs  = @(
            (Join-Path $UserHome ".gemini"),
            (Join-Path $UserHome ".gemini\antigravity")
        )
    },
    @{
        Name        = "Claude Code Skills"
        Link        = Join-Path $UserHome ".claude\skills"
        Source      = Join-Path $DiGidoHome ".agent\skills"
        ParentDirs  = @(
            (Join-Path $UserHome ".claude")
        )
    },
    @{
        Name        = "Claude Code Commands"
        Link        = Join-Path $UserHome ".claude\commands"
        Source      = Join-Path $DiGidoHome ".agent\workflows"
        ParentDirs  = @(
            (Join-Path $UserHome ".claude")
        )
    }
)

# ============================================================================
# Helper Functions
# ============================================================================

function Test-JunctionPrivilege {
    $testDir = Join-Path $env:TEMP "digido-junction-test-$(Get-Random)"
    $testTarget = $env:TEMP
    try {
        $null = cmd /c mklink /J "$testDir" "$testTarget" 2>&1
        if (Test-Path $testDir) {
            cmd /c rmdir "$testDir" 2>&1 | Out-Null
            return $true
        }
        return $false
    } catch {
        return $false
    }
}

function Test-IsJunction {
    param([string]$Path)
    if (-not (Test-Path $Path)) { return $false }
    $item = Get-Item $Path -Force -ErrorAction SilentlyContinue
    return ($item.Attributes -band [System.IO.FileAttributes]::ReparsePoint)
}

function Remove-Junction {
    param([string]$Path)
    if (Test-IsJunction $Path) {
        cmd /c rmdir "$Path" 2>&1 | Out-Null
        return $true
    }
    return $false
}

# ============================================================================
# Uninstall Mode
# ============================================================================

if ($Uninstall) {
    Write-Host ""
    Write-Host "Removing DiGido global connections..." -ForegroundColor Cyan
    Write-Host ""

    foreach ($target in $Targets) {
        if (Test-IsJunction $target.Link) {
            Remove-Junction $target.Link | Out-Null
            Write-Host "  Removed: $($target.Name)" -ForegroundColor Green
        } else {
            Write-Host "  Not found: $($target.Name) - skipping" -ForegroundColor Yellow
        }
    }

    Write-Host ""
    Write-Host "DiGido uninstalled. The skills source folder was NOT deleted." -ForegroundColor Green
    Write-Host ""
    exit 0
}

# ============================================================================
# Install Mode
# ============================================================================

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  DiGido Skills — Global Installer" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Source: $DiGidoHome" -ForegroundColor Gray
Write-Host ""

# Validate source
if (-not (Test-Path (Join-Path $DiGidoHome ".agent\skills"))) {
    Write-Host "ERROR: DiGido skills not found at: $DiGidoHome" -ForegroundColor Red
    Write-Host "Make sure you run this script from the digido-skills folder." -ForegroundColor Yellow
    Write-Host ""
    exit 1
}

# Check junction privileges
if (-not (Test-JunctionPrivilege)) {
    Write-Host "ERROR: Cannot create junctions!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please enable Developer Mode:" -ForegroundColor Yellow
    Write-Host "  1. Press Start (Windows key)" -ForegroundColor White
    Write-Host "  2. Type: Developer settings" -ForegroundColor White
    Write-Host "  3. Press Enter" -ForegroundColor White
    Write-Host "  4. Turn ON 'Developer Mode'" -ForegroundColor White
    Write-Host "  5. Click 'Yes' if prompted" -ForegroundColor White
    Write-Host "  6. Run this script again" -ForegroundColor White
    Write-Host ""
    Write-Host "Alternative: Right-click PowerShell -> Run as Administrator" -ForegroundColor Gray
    Write-Host ""
    exit 1
}

# Install each target
$successCount = 0
$totalCount = $Targets.Count

foreach ($target in $Targets) {
    # Create parent directories
    foreach ($dir in $target.ParentDirs) {
        if (-not (Test-Path $dir)) {
            New-Item -ItemType Directory -Path $dir -Force | Out-Null
        }
    }

    # Handle existing junction or folder
    if (Test-IsJunction $target.Link) {
        # Remove old junction and recreate
        Remove-Junction $target.Link | Out-Null
    } elseif (Test-Path $target.Link) {
        # Folder exists and is not a junction — ask user before copying
        if (-not (Test-Path $target.Source)) {
            Write-Host "  SKIP: Source not found for $($target.Name)" -ForegroundColor Yellow
            Write-Host "        Expected: $($target.Source)" -ForegroundColor Gray
            Write-Host ""
            continue
        }
        Write-Host "  NOTICE: $($target.Link)" -ForegroundColor Yellow
        Write-Host "          already exists as a regular folder." -ForegroundColor Yellow
        Write-Host ""
        Write-Host "  We will copy new files into it (without overwriting existing ones)." -ForegroundColor White
        Write-Host "  To update existing files later, run: .\update-digido.ps1" -ForegroundColor White
        Write-Host ""
        $answer = Read-Host "  Proceed with copy for $($target.Name)? (Y/N)"
        if ($answer -notmatch '^[Yy]') {
            Write-Host "  Skipped: $($target.Name)" -ForegroundColor Yellow
            Write-Host ""
            continue
        }
        $copied = 0
        $skipped = 0
        $sourceFiles = Get-ChildItem -Path $target.Source -File
        foreach ($file in $sourceFiles) {
            $destFile = Join-Path $target.Link $file.Name
            if (-not (Test-Path $destFile)) {
                Copy-Item -Path $file.FullName -Destination $destFile
                $copied++
            } else {
                $skipped++
            }
        }
        Write-Host "  COPY: $($target.Name)" -ForegroundColor Cyan
        Write-Host "        New files added: $copied | Already existed (not overwritten): $skipped" -ForegroundColor Gray
        Write-Host "        All files are now available." -ForegroundColor Green
        Write-Host "        To update existing files, run: .\update-digido.ps1" -ForegroundColor Yellow
        $successCount++
        Write-Host ""
        continue
    }

    # Verify source exists
    if (-not (Test-Path $target.Source)) {
        Write-Host "  SKIP: Source not found for $($target.Name)" -ForegroundColor Yellow
        Write-Host "        Expected: $($target.Source)" -ForegroundColor Gray
        continue
    }

    # Create junction
    $result = cmd /c mklink /J "$($target.Link)" "$($target.Source)" 2>&1
    if (Test-Path $target.Link) {
        Write-Host "  OK: $($target.Name)" -ForegroundColor Green
        Write-Host "      $($target.Link)" -ForegroundColor Gray
        Write-Host "      -> $($target.Source)" -ForegroundColor Gray
        $successCount++
    } else {
        Write-Host "  FAIL: $($target.Name)" -ForegroundColor Red
        Write-Host "        $result" -ForegroundColor Gray
    }
    Write-Host ""
}

# Summary
Write-Host "========================================" -ForegroundColor Cyan
if ($successCount -eq $totalCount) {
    Write-Host "  Installation complete! ($successCount/$totalCount)" -ForegroundColor Green
    Write-Host ""
    Write-Host "  Next step:" -ForegroundColor White
    Write-Host "  Open any project and tell the agent:" -ForegroundColor White
    Write-Host '  "What skills do you have?"' -ForegroundColor Cyan
} elseif ($successCount -gt 0) {
    Write-Host "  Partial installation ($successCount/$totalCount)" -ForegroundColor Yellow
    Write-Host "  Review warnings above." -ForegroundColor Yellow
} else {
    Write-Host "  Installation failed (0/$totalCount)" -ForegroundColor Red
    Write-Host "  Check the errors above." -ForegroundColor Red
}
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
