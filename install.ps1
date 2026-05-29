<#
.SYNOPSIS
    Interactive setup for this dotfiles repo. Lists every dependency
    and config-wiring task with its current state, lets you pick which
    to run.

.PARAMETER Yes
    Non-interactive: install/wire all missing tasks without prompting.

.PARAMETER All
    Non-interactive: run every task (re-wire even already-done ones).

.PARAMETER DryRun
    Show what would be done without making any changes. Combinable with
    -Yes or -All.

.PARAMETER PackageManager
    Which package manager to use for installs: 'winget' or 'choco'.
    Default: prompt interactively, or auto-detect in non-interactive mode
    (prefers winget, falls back to choco).

.EXAMPLE
    .\install.ps1
    .\install.ps1 -Yes
    .\install.ps1 -All
    .\install.ps1 -DryRun
    .\install.ps1 -Yes -DryRun
    .\install.ps1 -PackageManager choco
#>

param(
    [switch]$Yes,
    [switch]$All,
    [switch]$DryRun,
    [ValidateSet('winget','choco')]
    [string]$PackageManager
)

$ErrorActionPreference = 'Stop'
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$DotfilePath = Split-Path -Parent $MyInvocation.MyCommand.Path
$Timestamp   = Get-Date -Format 'yyyyMMdd-HHmmss'
$MarkerStart = "# >>> dotfiles ($DotfilePath) >>>"
$MarkerEnd   = "# <<< dotfiles <<<"
$StubTag     = "-- dotfiles stub: edits go in `$DOTFILE_PATH, not here"

function Info($msg) { Write-Host "==> $msg" -ForegroundColor Cyan }
function Warn($msg) { Write-Host "!!  $msg" -ForegroundColor Yellow }
function Have($cmd) { [bool](Get-Command $cmd -ErrorAction SilentlyContinue) }

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

function Install-Winget($id) {
    if (-not (Have 'winget')) {
        Warn "winget not found. Install 'App Installer' from Microsoft Store."
        throw "winget missing"
    }
    winget install --id $id --silent --accept-source-agreements --accept-package-agreements
}

function Install-Choco($id) {
    if (-not (Have 'choco')) {
        Warn "choco not found. Install from https://chocolatey.org/install"
        throw "choco missing"
    }
    choco install $id -y --no-progress
}

function Select-PackageManager {
    if ($PackageManager) { return $PackageManager }
    $hasWinget = Have 'winget'
    $hasChoco  = Have 'choco'

    if ($Yes -or $All) {
        if ($hasWinget) { return 'winget' }
        if ($hasChoco)  { return 'choco' }
        return 'winget'  # will error later with a useful message
    }

    Write-Host ''
    Info 'Package manager for dependency installs:'
    $wMark = if ($hasWinget) { 'installed' } else { 'missing' }
    $cMark = if ($hasChoco)  { 'installed' } else { 'missing' }
    Write-Host "  1) winget  [$wMark]"
    Write-Host "  2) choco   [$cMark]"
    $default = if ($hasWinget) { '1' } elseif ($hasChoco) { '2' } else { '1' }
    $resp = Read-Host "Pick [1/2] (default $default)"
    if (-not $resp) { $resp = $default }
    switch ($resp.Trim()) {
        '1' { return 'winget' }
        '2' { return 'choco' }
        'winget' { return 'winget' }
        'choco'  { return 'choco' }
        default  { Warn "unrecognized, using winget"; return 'winget' }
    }
}

# Per-dep package IDs keyed by manager.
function Install-Dep($ids) {
    switch ($script:PM) {
        'winget' { Install-Winget $ids.winget }
        'choco'  { Install-Choco  $ids.choco }
    }
}

function Describe-Dep($ids) {
    switch ($script:PM) {
        'winget' { "winget install --id $($ids.winget)" }
        'choco'  { "choco install $($ids.choco) -y" }
    }
}

function Has-Marker($file) {
    if (-not (Test-Path $file)) { return $false }
    (Get-Content -Raw $file -ErrorAction SilentlyContinue) -match [regex]::Escape($MarkerStart)
}

function Has-Stub($file) {
    if (-not (Test-Path $file)) { return $false }
    (Get-Content -Raw $file -ErrorAction SilentlyContinue) -match [regex]::Escape($StubTag)
}

function Has-GitInclude {
    $existing = git config --global --get-all include.path 2>$null
    $global:LASTEXITCODE = 0  # git returns 1 when no values match — not an error here
    $path = "$DotfilePath/config/gitconfig" -replace '\\', '/'
    $existing -and (($existing -split "`n") -contains $path)
}

function EnsureBlock($File, $Body) {
    $parent = Split-Path -Parent $File
    if ($parent -and -not (Test-Path $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
    if (-not (Test-Path $File))                { New-Item -ItemType File -Path $File -Force | Out-Null }
    if (Has-Marker $File) { return }
    Add-Content -Path $File -Value "`r`n$MarkerStart`r`n$Body`r`n$MarkerEnd"
}

function WriteStub($File, $Contents) {
    $parent = Split-Path -Parent $File
    if ($parent -and -not (Test-Path $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
    if ((Test-Path $File) -and -not (Has-Stub $File)) {
        Warn "backup $File -> $File.bak.$Timestamp"
        Move-Item -Path $File -Destination "$File.bak.$Timestamp" -Force
    }
    Set-Content -Path $File -Value $Contents -Encoding utf8
}

# ---------------------------------------------------------------------------
# Task definitions
# ---------------------------------------------------------------------------

$Tasks = @()
function Add-Task($label, $check, $action, $describe) {
    $script:Tasks += [pscustomobject]@{
        Label    = $label
        Check    = $check
        Action   = $action
        Describe = $describe
    }
}

function Describe-EnsureBlock($file, $body) {
    $lines = @("append marker block to ${file}:")
    $lines += "    $MarkerStart"
    foreach ($l in ($body -split "`r?`n")) { $lines += "    $l" }
    $lines += "    $MarkerEnd"
    $lines -join "`n"
}
function Describe-WriteStub($file, $contents) {
    $lines = @()
    if ((Test-Path $file) -and -not (Has-Stub $file)) {
        $lines += "back up existing $file -> $file.bak.$Timestamp"
    }
    $lines += "write stub to ${file}:"
    foreach ($l in ($contents -split "`r?`n")) { $lines += "    $l" }
    $lines -join "`n"
}

# --- deps ---
$DepIds = @{
    git      = @{ winget = 'Git.Git';                 choco = 'git' }
    nvim     = @{ winget = 'Neovim.Neovim';           choco = 'neovim' }
    starship = @{ winget = 'Starship.Starship';       choco = 'starship' }
    ripgrep  = @{ winget = 'BurntSushi.ripgrep.MSVC'; choco = 'ripgrep' }
    fd       = @{ winget = 'sharkdp.fd';              choco = 'fd' }
    bat      = @{ winget = 'sharkdp.bat';             choco = 'bat' }
    fzf      = @{ winget = 'junegunn.fzf';            choco = 'fzf' }
    wezterm  = @{ winget = 'wez.wezterm';             choco = 'wezterm' }
}

Add-Task "dep: git"      { Have 'git' }      { Install-Dep $DepIds.git }      { Describe-Dep $DepIds.git }
Add-Task "dep: neovim"   { Have 'nvim' }     { Install-Dep $DepIds.nvim }     { Describe-Dep $DepIds.nvim }
Add-Task "dep: starship" { Have 'starship' } { Install-Dep $DepIds.starship } { Describe-Dep $DepIds.starship }
Add-Task "dep: ripgrep"  { Have 'rg' }       { Install-Dep $DepIds.ripgrep }  { Describe-Dep $DepIds.ripgrep }
Add-Task "dep: fd"       { Have 'fd' }       { Install-Dep $DepIds.fd }       { Describe-Dep $DepIds.fd }
Add-Task "dep: bat"      { Have 'bat' }      { Install-Dep $DepIds.bat }      { Describe-Dep $DepIds.bat }
Add-Task "dep: fzf"      { Have 'fzf' }      { Install-Dep $DepIds.fzf }      { Describe-Dep $DepIds.fzf }
Add-Task "dep: wezterm"  { Have 'wezterm' }  { Install-Dep $DepIds.wezterm }  { Describe-Dep $DepIds.wezterm }
Add-Task "dep: posh-git" `
    { [bool](Get-Module -ListAvailable -Name posh-git) } `
    { Install-Module posh-git -Scope CurrentUser -Force } `
    { "Install-Module posh-git -Scope CurrentUser" }

# --- wire ---
$NvimInit    = Join-Path $env:LOCALAPPDATA 'nvim\init.lua'
$WeztermFile = Join-Path $HOME '.wezterm.lua'

$ProfileBody = @"
`$env:DOTFILE_PATH = '$DotfilePath'
`$env:STARSHIP_CONFIG = "`$env:DOTFILE_PATH\config\starship.toml"
. "`$env:DOTFILE_PATH\config\profile.ps1"
"@

$NvimStub = @"
$StubTag
vim.env.DOTFILE_PATH = vim.env.DOTFILE_PATH or [[$DotfilePath]]
dofile(vim.env.DOTFILE_PATH .. '/init.lua')
"@

$WeztermStub = @"
$StubTag
return dofile((os.getenv('DOTFILE_PATH') or [[$DotfilePath]]) .. '/config/wezterm.lua')
"@

$GitIncludePath = "$DotfilePath/config/gitconfig" -replace '\\','/'

Add-Task "wire: `$PROFILE" `
    { Has-Marker $PROFILE } `
    { EnsureBlock $PROFILE $ProfileBody } `
    { Describe-EnsureBlock $PROFILE $ProfileBody }

Add-Task "wire: nvim init.lua" `
    { Has-Stub $NvimInit } `
    { WriteStub $NvimInit $NvimStub } `
    { Describe-WriteStub $NvimInit $NvimStub }

Add-Task "wire: ~/.wezterm.lua" `
    { Has-Stub $WeztermFile } `
    { WriteStub $WeztermFile $WeztermStub } `
    { Describe-WriteStub $WeztermFile $WeztermStub }

Add-Task "wire: ~/.gitconfig include" `
    { Has-GitInclude } `
    { git config --global --add include.path $GitIncludePath } `
    { "git config --global --add include.path $GitIncludePath" }

# ---------------------------------------------------------------------------
# Menu
# ---------------------------------------------------------------------------

function Is-Done($task) {
    try { [bool](& $task.Check) } catch { $false }
}

function Render-Menu {
    for ($i = 0; $i -lt $Tasks.Count; $i++) {
        $t = $Tasks[$i]
        if (Is-Done $t) {
            $mark = '+'; $status = 'done   '; $color = 'Green'
        } else {
            $mark = '-'; $status = 'missing'; $color = 'Yellow'
        }
        Write-Host ("  ") -NoNewline
        Write-Host ("{0}" -f $mark) -ForegroundColor $color -NoNewline
        Write-Host (" {0,2}) [{1}] {2}" -f ($i + 1), $status, $t.Label)
    }
}

function Run-Task($i) {
    $t = $Tasks[$i]
    if ($DryRun) {
        Info "[dry-run] $($t.Label)"
        $detail = $null
        if ($t.Describe) {
            try { $detail = & $t.Describe } catch { $detail = "(describe failed: $_)" }
        }
        if ($detail) {
            foreach ($line in ($detail -split "`r?`n")) { Write-Host "    $line" }
        }
        return
    }
    Info "→ $($t.Label)"
    try {
        & $t.Action | Out-Null
        Info "  done"
    } catch {
        Warn "  failed: $_"
    }
}

function Parse-Selection($selection) {
    $total = $Tasks.Count
    switch -Regex ($selection.Trim().ToLower()) {
        '^(all|a)$'           { return 0..($total - 1) }
        '^(none|n|q|quit)$'   { return @() }
        '^(missing|m|)$'      {
            $out = @()
            for ($i = 0; $i -lt $total; $i++) {
                if (-not (Is-Done $Tasks[$i])) { $out += $i }
            }
            return $out
        }
        default {
            $out = @()
            foreach ($tok in ($selection -split '[,\s]+')) {
                if ($tok -match '^\d+$' -and [int]$tok -ge 1 -and [int]$tok -le $total) {
                    $out += [int]$tok - 1
                } elseif ($tok) {
                    Warn "skip invalid: $tok"
                }
            }
            return $out
        }
    }
}

function Interactive-Menu {
    Write-Host ''
    Info "DOTFILE_PATH=$DotfilePath"
    Write-Host ''
    Write-Host 'Tasks:'
    Render-Menu
    Write-Host ''
    Write-Host "Pick: numbers (e.g. 1,3,5), 'all', 'missing' (default), 'none' to quit."
    $selection = Read-Host '>'
    $indices = Parse-Selection $selection
    if (-not $indices -or $indices.Count -eq 0) { Info 'nothing to do.'; return }
    Write-Host ''
    foreach ($i in $indices) { Run-Task $i }
}

function Non-Interactive($mode) {
    Info "DOTFILE_PATH=$DotfilePath"
    $indices = @()
    if ($mode -eq 'all') {
        $indices = 0..($Tasks.Count - 1)
    } else {
        for ($i = 0; $i -lt $Tasks.Count; $i++) {
            if (-not (Is-Done $Tasks[$i])) { $indices += $i }
        }
    }
    if ($indices.Count -eq 0) { Info 'everything already done.'; return }
    foreach ($i in $indices) { Run-Task $i }
}

# ---------------------------------------------------------------------------
# Entrypoint
# ---------------------------------------------------------------------------

if ($DryRun) { Info 'DRY-RUN mode: no changes will be made' }

$script:PM = Select-PackageManager
Info "package manager: $script:PM"

if ($All) {
    Non-Interactive 'all'
} elseif ($Yes) {
    Non-Interactive 'missing'
} else {
    Interactive-Menu
}

Write-Host ''
if ($DryRun) {
    Info 'dry-run finished. re-run without -DryRun to apply.'
} else {
    Info 'open a new PowerShell window to pick up changes.'
}

exit 0
