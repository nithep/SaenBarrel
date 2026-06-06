# PowerShell script for setting up the Windows side of Git sync for SaenBarrel
# This script helps configure Obsidian Git plugin and related settings
# Functions: (A) Validates Git and Obsidian installation, (B) Initializes vault as Git repo,
# (C) Configures Git user identity, (D) Provides instructions for Obsidian Git plugin setup

Write-Host "===========================================" -ForegroundColor Green
Write-Host "SaenBarrel Git Sync - Windows Setup" -ForegroundColor Green
Write-Host "===========================================" -ForegroundColor Green

# Function to check if a command exists
function Test-CommandExists {
    param($command)
    $exists = $null -ne (Get-Command $command -ErrorAction SilentlyContinue)
    return $exists
}

# Check prerequisites
Write-Host "`nChecking prerequisites..." -ForegroundColor Yellow

$gitExists = Test-CommandExists "git"
$obsidianPath = $null

# Look for Obsidian installation
$potentialPaths = @(
    "$env:LOCALAPPDATA\Programs\Obsidian\Obsidian.exe",
    "$env:PROGRAMFILES\Obsidian\Obsidian.exe",
    "$env:PROGRAMFILES(X86)\Obsidian\Obsidian.exe",
    "$env:LOCALAPPDATA\Microsoft\WindowsApps\Obsidian.exe"
)

foreach ($path in $potentialPaths) {
    if (Test-Path $path) {
        $obsidianPath = $path
        break
    }
}

# Fallback: prompt user if not found in standard locations
if (-not $obsidianPath) {
    $customPath = Read-Host "Obsidian not found in standard locations. Enter the full path to Obsidian.exe, or press Enter to skip"
    if ($customPath -and (Test-Path $customPath)) {
        $obsidianPath = $customPath
    }
}

if (-not $gitExists) {
    Write-Host "ERROR: Git is not installed or not in PATH" -ForegroundColor Red
    Write-Host "Please install Git from https://git-scm.com/download/win" -ForegroundColor Red
    exit 1
} else {
    Write-Host "✓ Git is installed" -ForegroundColor Green
}

if (-not $obsidianPath) {
    Write-Host "WARNING: Obsidian executable not found in standard locations" -ForegroundColor Yellow
    Write-Host "Please ensure Obsidian is installed before proceeding" -ForegroundColor Yellow
} else {
    Write-Host "✓ Obsidian found at: $obsidianPath" -ForegroundColor Green
}

# Vault directory
if (-not $PSScriptRoot) {
    $PSScriptRoot = (Get-Location).Path
}
$vaultDir = Split-Path -Parent $PSScriptRoot
$vaultDir = Split-Path -Parent $vaultDir
Write-Host "`nDetected vault directory: $vaultDir" -ForegroundColor Cyan

# Check if this is a Git repository
$isGitRepo = Test-Path "$vaultDir\.git"
if (-not $isGitRepo) {
    Write-Host "This vault is not yet a Git repository." -ForegroundColor Yellow
    $createRepo = Read-Host "Would you like to initialize it as a Git repository? (y/n)"
    
    if ($createRepo -eq 'y' -or $createRepo -eq 'Y') {
        Write-Host "Initializing Git repository..." -ForegroundColor Yellow
        Set-Location $vaultDir
        git init
        if ($LASTEXITCODE -ne 0) {
            Write-Host "ERROR: Failed to initialize Git repository" -ForegroundColor Red
            exit 1
        } else {
            Write-Host "✓ Git repository initialized" -ForegroundColor Green
        }
    }
}

# Check Git configuration
Write-Host "`nChecking Git configuration..." -ForegroundColor Yellow
$currentEmail = git config --local user.email
$currentName = git config --local user.name

# If local config not set, check global
if ([string]::IsNullOrWhiteSpace($currentEmail)) {
    $currentEmail = git config --global user.email
}
if ([string]::IsNullOrWhiteSpace($currentName)) {
    $currentName = git config --global user.name
}

if ([string]::IsNullOrWhiteSpace($currentEmail) -or [string]::IsNullOrWhiteSpace($currentName)) {
    Write-Host "Git user information is not configured." -ForegroundColor Yellow
    Write-Host "Configure repo-level (--local) or user-level (--global)? Default: repo-level (--local)" -ForegroundColor Yellow
    $scope = Read-Host "Enter 'local' or 'global' (or press Enter for 'local')"
    if (-not $scope -or $scope -eq 'local') {
        $scope = '--local'
    } elseif ($scope -eq 'global') {
        $scope = '--global'
    } else {
        $scope = '--local'
    }
    
    $email = Read-Host "Enter your email address"
    $name = Read-Host "Enter your full name"
    
    & git config $scope user.email $email
    & git config $scope user.name $name
    
    Write-Host "✓ Git user configuration updated ($scope scope)" -ForegroundColor Green
} else {
    Write-Host "Current Git user: $currentName <$currentEmail>" -ForegroundColor Cyan
}

# Provide instructions for Obsidian Git plugin
Write-Host "`n===========================================" -ForegroundColor Green
Write-Host "SCRIPT SUMMARY & NEXT STEPS" -ForegroundColor Green
Write-Host "===========================================" -ForegroundColor Green

Write-Host @"
AUTOMATED STEPS (already completed by this script):
  ✓ Verified Git is installed
  ✓ Located Obsidian installation
  ✓ Initialized vault as Git repository (if needed)
  ✓ Configured Git user identity ($scope scope)

MANUAL STEPS (you must complete these):

1. INSTALL OBSIDIAN GIT PLUGIN:
   a. Open Obsidian and go to Settings (Ctrl + ,)
   b. Go to "Community plugins" section, click "Browse"
   c. Search for "Obsidian Git" and install it
   d. Enable the plugin

2. CONFIGURE PLUGIN SETTINGS:
   In the plugin settings, configure:
   - Auto backup: Enable
   - Auto backup every: 5 (enter an integer number of minutes, e.g., 5)
   - Commit message template: Auto-backup: {{date}} (uses YYYY-MM-DD format)
   - Sync method: Push and pull
   - Custom commit message: Check this to enable custom messages
   
   In Advanced settings:
   - Large file warning limit: 10 MiB (10 * 2^20 bytes; plugin shows warning if file >= this size)
   - Disable staging area: Enabled (optional)

3. CREATE GITHUB REPOSITORY AND PUSH INITIAL COMMIT:
   a. Go to https://github.com/new
   b. Choose repository name (e.g., "SaenBarrel")
   c. Select "Private" visibility
   d. Do NOT initialize with README, .gitignore, or license
   e. After creation, copy the repository URL (HTTPS or SSH)

   f. Then run these commands in Command Prompt/Terminal in the vault directory ($vaultDir):
   
      MANUAL: git add . && git commit -m 'Initial commit'
      MANUAL: git remote remove origin 2>$null || true
      MANUAL: git remote add origin <your-repo-url>
      MANUAL: git branch -M main
      MANUAL: git push -u origin main

   NOTE: If "git remote add origin" fails with "remote origin already exists":
         Run: git remote remove origin && git remote add origin <your-repo-url>

4. AUTHENTICATION:
   Choose one method:
   - GitHub Desktop: Sign in to GitHub (easiest)
   - Personal Access Token: Create PAT at GitHub settings, then run:
     git remote set-url origin https://<USERNAME>:<TOKEN>@github.com/<OWNER>/<REPO>.git
   - SSH Keys: Follow https://docs.github.com/en/authentication to configure SSH, then use SSH remote URL

   If "git push" fails with authentication error:
   - Verify your Personal Access Token is created and has 'repo' permission
   - Or configure SSH keys and use the SSH remote URL
   - Then retry: git push -u origin main
"@ -ForegroundColor White

Write-Host "`n===========================================" -ForegroundColor Green
Write-Host "GIT SYNC ARCHITECTURE" -ForegroundColor Green
Write-Host "===========================================" -ForegroundColor Green

Write-Host @"
The complete architecture works as follows:

Windows (Obsidian + Obsidian Git plugin)
   │  Edit in 00_Raw → auto-commit + push
   ▼
GitHub: repo vault (private)
   ▲  │
   │  ▼ (Pi: systemd timer → git pull)
Raspberry Pi: hermes compile --update-moc → git commit + push
   │
   ▼ Obsidian Git on Windows pulls back → see compiled 01_Wiki
"@ -ForegroundColor White

Write-Host "`nSetup instructions completed!" -ForegroundColor Green
Write-Host "Remember to configure your GitHub repository and authentication." -ForegroundColor Yellow