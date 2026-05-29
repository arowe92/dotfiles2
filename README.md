# dotfiles

Personal config for Neovim, PowerShell, zsh, wezterm, tmux, starship,
ranger, git, bat, ripgrep.

## How it works

This repo is the **source of truth**. Nothing gets copied or symlinked.
The install script wires the canonical config paths to point back here:

- **Shell rc files** (`~/.zshrc`, PowerShell `$PROFILE`) — get a
  marker-delimited block appended that exports `$DOTFILE_PATH` and
  sources the repo's init.
- **Other configs** (`~/.tmux.conf`, nvim `init.lua`, `~/.wezterm.lua`)
  — get a tiny stub file that loads the real config from
  `$DOTFILE_PATH`. Edit the repo, not the stub.
- **Git** — `~/.gitconfig` gets an `include.path` entry, leaving your
  local credentials/overrides intact.

Edits in this repo are immediately live in any new shell.

## Install

Both scripts launch an interactive menu listing every dependency and
config-wiring task with its current status. Pick what you want to run —
numbers (e.g. `1,3,5`), `all`, `missing` (default), or `none` to quit.

### Windows (PowerShell)

```powershell
.\install.ps1            # interactive menu
.\install.ps1 -Yes       # non-interactive: do all missing
.\install.ps1 -All       # non-interactive: run every task
.\install.ps1 -DryRun    # show what would happen, change nothing
```

Deps are installed via `winget`: Git, Neovim, Starship, ripgrep, fd,
bat, fzf, wezterm, plus the `posh-git` PowerShell module.

### Linux / macOS

```sh
./install.sh             # interactive menu
./install.sh -y          # non-interactive: do all missing
./install.sh --all       # non-interactive: run every task
./install.sh -n          # dry-run: show what would happen, change nothing
```

Deps are installed via the detected package manager (apt, dnf, pacman,
or brew): git, zsh, tmux, ranger, neovim, ripgrep, fd, bat, fzf.
Starship is installed via its official installer, and
[antidote](https://github.com/mattmc3/antidote) is cloned to `~/.antidote`.

Both scripts are idempotent — re-running skips already-installed tools
and already-wired files. Pre-existing real files at stub locations get
backed up to `*.bak.<timestamp>` before being replaced.

## What gets wired

| Tool       | Target (Linux)                   | Target (Windows)                  | Source in repo               |
|------------|----------------------------------|-----------------------------------|------------------------------|
| Shell      | `~/.zshrc` (sourced block)       | `$PROFILE` (sourced block)        | `zsh/init.zsh`, `config/profile.ps1` |
| Neovim     | `~/.config/nvim/init.lua` (stub) | `%LOCALAPPDATA%\nvim\init.lua` (stub) | `init.lua`               |
| Wezterm    | `~/.wezterm.lua` (stub)          | `~/.wezterm.lua` (stub)           | `config/wezterm.lua`         |
| Tmux       | `~/.tmux.conf` (`source-file`)   | —                                 | `config/tmux.conf`           |
| Starship   | `$STARSHIP_CONFIG` env var       | `$env:STARSHIP_CONFIG` env var    | `config/starship.toml`       |
| Git        | `~/.gitconfig` (`include.path`)  | `~/.gitconfig` (`include.path`)   | `config/gitconfig`           |
| Bat        | `$BAT_CONFIG_PATH` env var       | `$env:BAT_CONFIG_PATH` env var    | `config/bat.conf`            |
| Ripgrep    | `$RIPGREP_CONFIG_PATH` env var   | `$env:RIPGREP_CONFIG_PATH` env var | `config/ripgreprc`          |

`$DOTFILE_PATH` is exported by the shell init blocks; everything else
references it.

## Layout

```
bin/          executables added to PATH
config/       app configs (bat, ranger, snippets, starship, tmux,
              wezterm, ripgreprc, gitconfig, profile.ps1)
init.lua      Neovim entry point (appends repo to runtimepath)
lua/          Neovim config tree (lazy.nvim plugins, options, keymaps)
zsh/          zsh init, aliases, functions, fzf bindings
vim/          legacy vim config (kept for reference)
vscode/       legacy VS Code keymap (kept for reference)
Zed/          Zed editor config
KEYBINDINGS.md  editor-agnostic keymap reference
```

## Uninstall

Remove the `dotfiles` block from `~/.zshrc` / `$PROFILE` / `~/.tmux.conf`,
delete the stub `init.lua` / `.wezterm.lua` files, and:

```sh
git config --global --unset include.path <repo>/config/gitconfig
```
