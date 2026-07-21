<#
╔══════════════════════════════════════════════════════════════╗
║  deep-mind 🧠 — Critical Thinking Engine for AI Agents     ║
║  Interactive Installer (Windows / PowerShell)                ║
╚══════════════════════════════════════════════════════════════╝
#>

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$SkillSrc = Join-Path $ScriptDir ".claude\skills\deep-mind"

function Write-Banner {
    Clear-Host
    Write-Host "╔═══════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║       🧠 deep-mind — Installer            ║" -ForegroundColor Cyan
    Write-Host "║  Critical Thinking Engine for AI Agents   ║" -ForegroundColor Cyan
    Write-Host "╚═══════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""
}

function Get-UserHome {
    return $env:USERPROFILE
}

function Get-Agents {
    $agents = @()
    $home = Get-UserHome

    # Claude Code
    if (Test-Path "$home\.claude") {
        $agents += [PSCustomObject]@{ Key="claude"; Name="Claude Code"; Path="$home\.claude\skills"; Detected=$true }
    }

    # Cursor
    $cursorPath = if (Test-Path "$home\.cursor") { "$home\.cursor" } elseif (Test-Path "$home\.config\cursor") { "$home\.config\cursor" } else { $null }
    if ($cursorPath) { $agents += [PSCustomObject]@{ Key="cursor"; Name="Cursor"; Path="$cursorPath\skills"; Detected=$true } }

    # Windsurf
    $wsPath = if (Test-Path "$home\.windsurf") { "$home\.windsurf" } elseif (Test-Path "$home\.config\windsurf") { "$home\.config\windsurf" } else { $null }
    if ($wsPath) { $agents += [PSCustomObject]@{ Key="windsurf"; Name="Windsurf"; Path="$wsPath\skills"; Detected=$true } }

    # GitHub Copilot
    if (Get-Command gh -ErrorAction SilentlyContinue) {
        $copilotPath = "$home\.copilot\skills"
        if (-not (Test-Path $copilotPath)) { New-Item -ItemType Directory -Path $copilotPath -Force | Out-Null }
        $agents += [PSCustomObject]@{ Key="copilot"; Name="GitHub Copilot CLI"; Path=$copilotPath; Detected=$true }
    }

    # Codex CLI
    if ((Test-Path "$home\.codex") -or (Get-Command codex -ErrorAction SilentlyContinue)) {
        $agents += [PSCustomObject]@{ Key="codex"; Name="Codex CLI"; Path="$home\.codex\skills"; Detected=$true }
    }

    # Cline
    if ((Test-Path "$home\.config\Code\globalStorage\saoudrizwan.claude-dev")) {
        $agents += [PSCustomObject]@{ Key="cline"; Name="Cline"; Path="$home\.config\cline\skills"; Detected=$true }
    }

    # Aider
    if (Get-Command aider -ErrorAction SilentlyContinue) {
        $agents += [PSCustomObject]@{ Key="aider"; Name="Aider"; Path="$home\.aider\skills"; Detected=$true }
    }

    # Continue
    $contPath = if (Test-Path "$home\.continue") { "$home\.continue" } elseif (Test-Path "$home\.config\continue") { "$home\.config\continue" } else { $null }
    if ($contPath) { $agents += [PSCustomObject]@{ Key="continue"; Name="Continue"; Path="$contPath\skills"; Detected=$true } }

    # Roo Code
    $rooPath = if (Test-Path "$home\.roocode") { "$home\.roocode" } elseif (Test-Path "$home\.config\roocode") { "$home\.config\roocode" } else { $null }
    if ($rooPath) { $agents += [PSCustomObject]@{ Key="roocode"; Name="Roo Code"; Path="$rooPath\skills"; Detected=$true } }

    # Augment
    if ((Test-Path "$home\.augment") -or (Get-Command augment -ErrorAction SilentlyContinue)) {
        $agents += [PSCustomObject]@{ Key="augment"; Name="Augment"; Path="$home\.augment\skills"; Detected=$true }
    }

    # OpenCode
    $ocPath = if (Test-Path "$home\.config\opencode") { "$home\.config\opencode" } elseif (Test-Path "$home\.opencode") { "$home\.opencode" } else { $null }
    if ($ocPath) { $agents += [PSCustomObject]@{ Key="opencode"; Name="OpenCode"; Path="$ocPath\skills"; Detected=$true } }

    return $agents
}

function Install-Skill {
    param($Agent)
    $targetPath = $Agent.Path
    $skillPath = Join-Path $targetPath "deep-mind"
    
    # Create directories
    New-Item -ItemType Directory -Path "$skillPath\references" -Force | Out-Null
    
    # Copy files
    Copy-Item -Path "$SkillSrc\SKILL.md" -Destination "$skillPath\" -Force
    if (Test-Path "$SkillSrc\references") {
        Copy-Item -Path "$SkillSrc\references\*" -Destination "$skillPath\references\" -Force -Recurse
    }
    
    Write-Host "  ✅ $($Agent.Name) → $skillPath" -ForegroundColor Green
}

function Uninstall-Skill {
    param($Agent)
    $skillPath = Join-Path $Agent.Path "deep-mind"
    if (Test-Path $skillPath) {
        Remove-Item -Path $skillPath -Recurse -Force
        Write-Host "  🗑️  Removed from $($Agent.Name)" -ForegroundColor Green
    }
}

# ══════════════════════ MAIN ══════════════════════

Write-Banner

$agents = Get-Agents

if ($args[0] -eq "--uninstall") {
    Write-Host "🗑️  Uninstalling deep-mind from all agents..." -ForegroundColor Yellow
    foreach ($agent in $agents) { Uninstall-Skill $agent }
    Write-Host "✔️  Uninstall selesai!" -ForegroundColor Green
    exit 0
}

if ($args[0] -eq "--dry-run") {
    Write-Host "🔍 Preview: Akan install skill ke agent berikut:" -ForegroundColor Yellow
    foreach ($agent in $agents) { Write-Host "  • $($agent.Name) ($($agent.Path))" }
    exit 0
}

if ($agents.Count -eq 0) {
    Write-Host "❌  Tidak ada AI coding agent terdeteksi di sistem ini." -ForegroundColor Red
    Write-Host ""
    Write-Host "Pastikan minimal satu agent terinstall:"
    Write-Host "  Claude Code, Cursor, Windsurf, Copilot CLI, Codex, dll."
    exit 1
}

Write-Host "🔍 Agent terdeteksi:" -ForegroundColor Green
foreach ($agent in $agents) { Write-Host "  ✅ $($agent.Name)" }
Write-Host ""

if ($agents.Count -eq 1) {
    Write-Host "→ Hanya 1 agent terdeteksi. Install otomatis." -ForegroundColor Cyan
    $selected = $agents
} else {
    # Build selection menu with Out-GridView if available, otherwise console selection
    if (Get-Command Out-GridView -ErrorAction SilentlyContinue) {
        Write-Host "📋  Memilih agent (gunakan checklist dialog)..." -ForegroundColor Yellow
        $selectedNames = $agents | Out-GridView -Title "Pilih AI Agent untuk deep-mind" -OutputMode Multiple
        if ($selectedNames.Count -eq 0) {
            Write-Host "❌  Tidak ada agent dipilih. Keluar." -ForegroundColor Red
            exit 1
        }
        $selected = $agents | Where-Object { $_.Name -in $selectedNames.Name }
    } else {
        # Fallback: console selection
        Write-Host "Pilih AI Agent untuk dipasang skill ini:" -ForegroundColor Yellow
        Write-Host ""
        for ($i = 0; $i -lt $agents.Count; $i++) {
            Write-Host "  [$($i+1)] $($agents[$i].Name)"
        }
        Write-Host ""
        $input = Read-Host "Masukkan nomor (pisah koma/spasi, atau 'all')"
        
        if ($input -eq "all") {
            $selected = $agents
        } else {
            $indices = $input -split '[, ]' | Where-Object { $_ -match '^\d+$' } | ForEach-Object { [int]$_ - 1 }
            $selected = $agents[$indices] | Where-Object { $_ -ne $null }
        }
    }
}

# Install
Write-Host ""
Write-Host "📦  Menginstall deep-mind skill..." -ForegroundColor Yellow
$count = 0
foreach ($agent in $selected) {
    Install-Skill $agent
    $count++
}

Write-Host ""
Write-Host "✔️  Selesai! deep-mind terinstall di $count agent(s)." -ForegroundColor Green
Write-Host ""
Write-Host "📖  Cara pakai: cukup mulai prompt dengan trigger phrase seperti:" -ForegroundColor Cyan
Write-Host '    "think deeper: ...", "critical analysis: ...", "first principles: ..."'
Write-Host ""
Write-Host "🗑️  Uninstall: powershell -File install.ps1 --uninstall" -ForegroundColor Gray
