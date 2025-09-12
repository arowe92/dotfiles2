$env:DOTFILE_PATH="$PSScriptRoot\.."

Invoke-Expression (&starship init powershell)

$env:RIPGREP_CONFIG_PATH="$env:DOTFILE_PATH\config\ripgreprc"

function gs { git status }
Set-Alias s gs

function gadd { git add --patch}
Set-Alias add gadd

Set-Alias touch New-Item
Set-Alias which Get-Command
Set-Alias grep Select-String
Set-Alias top Get-Process

if (Test-Path "$env:HOMEPATH\profile.ps1") {
    . "$env:HOMEPATH\profile.ps1"
}

