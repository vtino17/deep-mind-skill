<#
â•”â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•—
â•‘  deep-mind - Critical Thinking Engine for AI Agents         â•‘
â•‘  Interactive Installer (Windows / PowerShell)                â•‘
â•šâ•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
#>

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$SkillSrc = Join-Path $ScriptDir ".claude\skills\deep-mind"

function Write-Banner {
    Clear-Host
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host "  deep-mind - Installer" -ForegroundColor Cyan
    Write-Host "  Critical Thinking Engine for AI Agents" -ForegroundColor Cyan
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host ""
}

function Get-UserHome {
    return $env:USERPROFILE
}

function Get-Agents {
    $agents = @()
    $userHome = Get-UserHome

    if (Test-Path "$userHome\.claude") {
        $agents += [PSCustomObject]@{ Key="claude"; Name="Claude Code"; Path="$userHome\.claude\skills"; Detected=$true }
    }

    $cursorPath = if (Test-Path "$userHome\.cursor") { "$userHome\.cursor" } elseif (Test-Path "$userHome\.config\cursor") { "$userHome\.config\cursor" } else { $null }
    if ($cursorPath) { $agents += [PSCustomObject]@{ Key="cursor"; Name="Cursor"; Path="$cursorPath\skills"; Detected=$true } }

    $wsPath = if (Test-Path "$userHome\.windsurf") { "$userHome\.windsurf" } elseif (Test-Path "$userHome\.config\windsurf") { "$userHome\.config\windsurf" } else { $null }
    if ($wsPath) { $agents += [PSCustomObject]@{ Key="windsurf"; Name="Windsurf"; Path="$wsPath\skills"; Detected=$true } }

    if (Get-Command gh -ErrorAction SilentlyContinue) {
        $copilotPath = "$userHome\.copilot\skills"
        if (-not (Test-Path $copilotPath)) { New-Item -ItemType Directory -Path $copilotPath -Force | Out-Null }
        $agents += [PSCustomObject]@{ Key="copilot"; Name="GitHub Copilot CLI"; Path=$copilotPath; Detected=$true }
    }

    if ((Test-Path "$userHome\.codex") -or (Get-Command codex -ErrorAction SilentlyContinue)) {
        $agents += [PSCustomObject]@{ Key="codex"; Name="Codex CLI"; Path="$userHome\.codex\skills"; Detected=$true }
    }

    if ((Test-Path "$userHome\.config\Code\globalStorage\saoudrizwan.claude-dev")) {
        $agents += [PSCustomObject]@{ Key="cline"; Name="Cline"; Path="$userHome\.config\cline\skills"; Detected=$true }
    }

    if (Get-Command aider -ErrorAction SilentlyContinue) {
        $agents += [PSCustomObject]@{ Key="aider"; Name="Aider"; Path="$userHome\.aider\skills"; Detected=$true }
    }

    $contPath = if (Test-Path "$userHome\.continue") { "$userHome\.continue" } elseif (Test-Path "$userHome\.config\continue") { "$userHome\.config\continue" } else { $null }
    if ($contPath) { $agents += [PSCustomObject]@{ Key="continue"; Name="Continue"; Path="$contPath\skills"; Detected=$true } }

    $rooPath = if (Test-Path "$userHome\.roocode") { "$userHome\.roocode" } elseif (Test-Path "$userHome\.config\roocode") { "$userHome\.config\roocode" } else { $null }
    if ($rooPath) { $agents += [PSCustomObject]@{ Key="roocode"; Name="Roo Code"; Path="$rooPath\skills"; Detected=$true } }

    if ((Test-Path "$userHome\.augment") -or (Get-Command augment -ErrorAction SilentlyContinue)) {
        $agents += [PSCustomObject]@{ Key="augment"; Name="Augment"; Path="$userHome\.augment\skills"; Detected=$true }
    }

    $ocPath = if (Test-Path "$userHome\.config\opencode") { "$userHome\.config\opencode" } elseif (Test-Path "$userHome\.opencode") { "$userHome\.opencode" } else { $null }
    if ($ocPath) { $agents += [PSCustomObject]@{ Key="opencode"; Name="OpenCode"; Path="$ocPath\skills"; Detected=$true } }

    return $agents
}

function Install-Skill {
    param($Agent)
    $targetPath = $Agent.Path
    $skillPath = Join-Path $targetPath "deep-mind"
    
    New-Item -ItemType Directory -Path "$skillPath\references" -Force | Out-Null
    
    Copy-Item -Path "$SkillSrc\SKILL.md" -Destination "$skillPath\" -Force
    if (Test-Path "$SkillSrc\references") {
        Copy-Item -Path "$SkillSrc\references\*" -Destination "$skillPath\references\" -Force -Recurse
    }
    
    Write-Host "  [OK] $($Agent.Name) -> $skillPath" -ForegroundColor Green
}

function Uninstall-Skill {
    param($Agent)
    $skillPath = Join-Path $Agent.Path "deep-mind"
    if (Test-Path $skillPath) {
        Remove-Item -Path $skillPath -Recurse -Force
        Write-Host "  [Removed] $($Agent.Name)" -ForegroundColor Green
    }
}

# ====== MAIN ======

Write-Banner

$agents = Get-Agents

if ($args[0] -eq "--uninstall") {
    Write-Host "Uninstalling deep-mind from all agents..." -ForegroundColor Yellow
    foreach ($agent in $agents) { Uninstall-Skill $agent }
    Write-Host "Done!" -ForegroundColor Green
    exit 0
}

if ($args[0] -eq "--dry-run") {
    Write-Host "Preview: Will install skill to:" -ForegroundColor Yellow
    foreach ($agent in $agents) { Write-Host "  - $($agent.Name) ($($agent.Path))" }
    exit 0
}

if ($agents.Count -eq 0) {
    Write-Host "[ERROR] No AI coding agents detected." -ForegroundColor Red
    Write-Host "Make sure at least one agent is installed: Claude Code, Cursor, Windsurf, etc."
    exit 1
}

Write-Host "Detected agents:" -ForegroundColor Green
foreach ($agent in $agents) { Write-Host "  [OK] $($agent.Name)" }
Write-Host ""

if ($agents.Count -eq 1) {
    Write-Host "Only 1 agent detected. Auto-installing." -ForegroundColor Cyan
    $selected = $agents
} else {
    if (Get-Command Out-GridView -ErrorAction SilentlyContinue) {
        Write-Host "Select agents using checklist dialog..." -ForegroundColor Yellow
        $selectedNames = $agents | Out-GridView -Title "Select AI agents for deep-mind" -OutputMode Multiple
        if ($selectedNames.Count -eq 0) {
            Write-Host "No agent selected. Exiting." -ForegroundColor Red
            exit 1
        }
        $selected = $agents | Where-Object { $_.Name -in $selectedNames.Name }
    } else {
        Write-Host "Select AI agents to install:" -ForegroundColor Yellow
        Write-Host ""
        for ($i = 0; $i -lt $agents.Count; $i++) {
            Write-Host "  [$($i+1)] $($agents[$i].Name)"
        }
        Write-Host ""
        $input = Read-Host "Enter numbers (comma/space separated, or 'all')"
        
        if ($input -eq "all") {
            $selected = $agents
        } else {
            $indices = $input -split '[, ]' | Where-Object { $_ -match '^\d+$' } | ForEach-Object { [int]$_ - 1 }
            $selected = $agents[$indices] | Where-Object { $_ -ne $null }
        }
    }
}

Write-Host ""
Write-Host "Installing deep-mind skill..." -ForegroundColor Yellow
$count = 0
foreach ($agent in $selected) {
    Install-Skill $agent
    $count++
}

Write-Host ""
Write-Host "Done! deep-mind installed on $count agent(s)." -ForegroundColor Green
Write-Host ""
Write-Host "Usage:" -ForegroundColor Cyan
Write-Host '  Start prompts with: "think deeper: ...", "critical analysis: ...", "first principles: ..."'
Write-Host ""
Write-Host "Uninstall: powershell -File install.ps1 --uninstall" -ForegroundColor Gray
