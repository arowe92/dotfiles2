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

$env:EDITOR="nvim"

function nvr {
    param(
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$Files
    )

    if ($env:NVIM) {
        foreach ($file in $Files) {
            $fullPath = Resolve-Path $file -ErrorAction SilentlyContinue
            if (-not $fullPath) {
                $fullPath = Join-Path (Get-Location) $file
            }
            nvim --server $env:NVIM --remote $fullPath
        }
    } else {
        neovide @Files
    }
}

function ncd {
    param(
        [Parameter(Position=0)]
        [string]$Path = "."
    )

    $fullPath = Resolve-Path $Path -ErrorAction SilentlyContinue
    if (-not $fullPath) {
        Write-Error "Directory not found: $Path"
        return
    }

    if ($env:NVIM) {
        $escaped = $fullPath -replace '\\', '/'
        nvim --server $env:NVIM --remote-send "<C-\><C-n>:cd $escaped | lua require('nvim-tree.api').tree.change_root(vim.fn.getcwd())<CR>"
    }

    Set-Location $fullPath
}
