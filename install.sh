#!/usr/bin/env bash
# Interactive setup for this dotfiles repo. Lists every dependency and
# config-wiring task with its current state, lets you pick which to run.
#
# Usage:
#   ./install.sh           # interactive menu
#   ./install.sh -y        # non-interactive: install/wire all missing
#   ./install.sh --all     # non-interactive: run every task (re-wire too)
#   ./install.sh -n        # dry-run: show what would be done, change nothing
#                          # (combine: ./install.sh -n -y, ./install.sh -n --all)

set -euo pipefail

DRY_RUN=0

DOTFILE_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
MARKER_START="# >>> dotfiles ($DOTFILE_PATH) >>>"
MARKER_END="# <<< dotfiles <<<"
STUB_TAG="-- dotfiles stub: edits go in \$DOTFILE_PATH, not here"

info() { printf '\033[36m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[33m!! \033[0m %s\n' "$*" >&2; }
have() { command -v "$1" >/dev/null 2>&1; }

# ---------------------------------------------------------------------------
# Package manager
# ---------------------------------------------------------------------------

detect_pm() {
    case "$(uname -s)" in
        Darwin) echo brew ;;
        Linux)
            if   have apt-get; then echo apt
            elif have dnf;     then echo dnf
            elif have pacman;  then echo pacman
            elif have brew;    then echo brew
            else echo unknown
            fi ;;
        *) echo unknown ;;
    esac
}

PM="$(detect_pm)"
APT_UPDATED=0

pm_install_one() {
    local pkg="$1"
    case "$PM" in
        apt)
            [ "$APT_UPDATED" = 0 ] && sudo apt-get update && APT_UPDATED=1
            sudo apt-get install -y "$pkg" ;;
        dnf)    sudo dnf install -y "$pkg" ;;
        pacman) sudo pacman -S --needed --noconfirm "$pkg" ;;
        brew)   brew install "$pkg" ;;
        unknown) warn "no package manager — install '$pkg' manually"; return 1 ;;
    esac
}

# Generic name -> per-PM package name.
pkg_for() {
    case "$PM:$1" in
        apt:fd)        echo fd-find ;;
        apt:nvim)      echo neovim ;;
        dnf:nvim)      echo neovim ;;
        pacman:nvim)   echo neovim ;;
        brew:nvim)     echo neovim ;;
        *)             echo "$1" ;;
    esac
}

# ---------------------------------------------------------------------------
# Task definitions
# ---------------------------------------------------------------------------
# Each task: a label, a "done?" check, and an action. Parallel arrays.

T_LABEL=(); T_CHECK=(); T_ACTION=()

task() { T_LABEL+=("$1"); T_CHECK+=("$2"); T_ACTION+=("$3"); }

# --- deps ---
have_cmd()    { have "$1"; }
install_pkg() { pm_install_one "$(pkg_for "$1")"; }

task "dep: git"        "have_cmd git"      "install_pkg git"
task "dep: zsh"        "have_cmd zsh"      "install_pkg zsh"
task "dep: tmux"       "have_cmd tmux"     "install_pkg tmux"
task "dep: ranger"     "have_cmd ranger"   "install_pkg ranger"
task "dep: neovim"     "have_cmd nvim"     "install_pkg nvim"
task "dep: ripgrep"    "have_cmd rg"       "install_pkg ripgrep"
task "dep: fd"         "have_cmd fd"       "install_pkg fd"
task "dep: bat"        "have_cmd bat"      "install_pkg bat"
task "dep: fzf"        "have_cmd fzf"      "install_pkg fzf"
task "dep: starship"   "have_cmd starship" "install_starship"
task "dep: antidote"   "test -d $HOME/.antidote" "install_antidote"

install_starship() { curl -sS https://starship.rs/install.sh | sh -s -- -y; }
install_antidote() { git clone --depth=1 https://github.com/mattmc3/antidote.git "$HOME/.antidote"; }

# --- wire ---
has_marker() { [ -f "$1" ] && grep -qF "$MARKER_START" "$1"; }
has_stub()   { [ -f "$1" ] && grep -qF "$STUB_TAG" "$1"; }
has_git_include() {
    git config --global --get-all include.path 2>/dev/null \
        | grep -qF "$DOTFILE_PATH/config/gitconfig"
}

ensure_block() {
    local file="$1" body="$2"
    mkdir -p "$(dirname "$file")"
    touch "$file"
    has_marker "$file" && return
    printf '\n%s\n%s\n%s\n' "$MARKER_START" "$body" "$MARKER_END" >> "$file"
}

write_stub() {
    local file="$1" contents="$2"
    mkdir -p "$(dirname "$file")"
    if [ -e "$file" ] && ! has_stub "$file"; then
        warn "backup $file -> $file.bak.$TIMESTAMP"
        mv "$file" "$file.bak.$TIMESTAMP"
    fi
    printf '%s\n' "$contents" > "$file"
}

wire_zshrc() {
    ensure_block "$HOME/.zshrc" "$(cat <<EOF
export DOTFILE_PATH="$DOTFILE_PATH"
export STARSHIP_CONFIG="\$DOTFILE_PATH/config/starship.toml"
source "\$DOTFILE_PATH/zsh/init.zsh"
EOF
)"
}

wire_tmux()    { ensure_block "$HOME/.tmux.conf" "source-file '$DOTFILE_PATH/config/tmux.conf'"; }

wire_nvim() {
    write_stub "$HOME/.config/nvim/init.lua" "$(cat <<EOF
$STUB_TAG
vim.env.DOTFILE_PATH = vim.env.DOTFILE_PATH or '$DOTFILE_PATH'
dofile(vim.env.DOTFILE_PATH .. '/init.lua')
EOF
)"
}

wire_wezterm() {
    write_stub "$HOME/.wezterm.lua" "$(cat <<EOF
$STUB_TAG
return dofile((os.getenv('DOTFILE_PATH') or '$DOTFILE_PATH') .. '/config/wezterm.lua')
EOF
)"
}

wire_git() { git config --global --add include.path "$DOTFILE_PATH/config/gitconfig"; }

task "wire: ~/.zshrc"                  "has_marker $HOME/.zshrc"               "wire_zshrc"
task "wire: ~/.tmux.conf"              "has_marker $HOME/.tmux.conf"           "wire_tmux"
task "wire: ~/.config/nvim/init.lua"   "has_stub $HOME/.config/nvim/init.lua"  "wire_nvim"
task "wire: ~/.wezterm.lua"            "has_stub $HOME/.wezterm.lua"           "wire_wezterm"
task "wire: ~/.gitconfig include"      "has_git_include"                       "wire_git"

# ---------------------------------------------------------------------------
# Menu
# ---------------------------------------------------------------------------

render_menu() {
    local i status mark
    for i in "${!T_LABEL[@]}"; do
        if eval "${T_CHECK[$i]}" >/dev/null 2>&1; then
            status='done   '
            mark='\033[32m✓\033[0m'
        else
            status='missing'
            mark='\033[33m·\033[0m'
        fi
        printf "  %b %2d) [%s] %s\n" "$mark" "$((i+1))" "$status" "${T_LABEL[$i]}"
    done
}

# Returns 0 if task $1 is already done.
is_done() { eval "${T_CHECK[$1]}" >/dev/null 2>&1; }

# Run task index $1.
run_task() {
    local i="$1"
    if [ "$DRY_RUN" = 1 ]; then
        info "[dry-run] would run: ${T_LABEL[$i]}  ::  ${T_ACTION[$i]}"
        return
    fi
    info "→ ${T_LABEL[$i]}"
    if eval "${T_ACTION[$i]}"; then
        info "  done"
    else
        warn "  failed"
    fi
}

parse_selection() {
    # Echoes a space-separated list of 0-based task indices.
    local input="$1" total="${#T_LABEL[@]}"
    case "$input" in
        all|a) seq 0 $((total - 1)) | tr '\n' ' ' ;;
        missing|m|"")
            local i out=""
            for i in "${!T_LABEL[@]}"; do
                is_done "$i" || out+="$i "
            done
            printf '%s' "$out" ;;
        none|n|q) ;;
        *)
            local token out=""
            for token in ${input//,/ }; do
                if [[ "$token" =~ ^[0-9]+$ ]] && [ "$token" -ge 1 ] && [ "$token" -le "$total" ]; then
                    out+="$((token - 1)) "
                else
                    warn "skip invalid: $token"
                fi
            done
            printf '%s' "$out" ;;
    esac
}

interactive_menu() {
    echo
    info "DOTFILE_PATH=$DOTFILE_PATH"
    info "package manager: $PM"
    echo
    echo "Tasks:"
    render_menu
    echo
    echo "Pick: numbers (e.g. 1,3,5), 'all', 'missing' (default), 'none'/'q' to quit."
    printf "> "
    local input; read -r input || input="q"
    [ "$input" = q ] || [ "$input" = none ] || [ "$input" = n ] && { info "nothing to do."; return; }
    local indices; indices="$(parse_selection "$input")"
    [ -z "$indices" ] && { info "nothing selected."; return; }
    echo
    for i in $indices; do run_task "$i"; done
}

non_interactive() {
    local indices=""
    case "${1:-missing}" in
        all)     indices="$(seq 0 $((${#T_LABEL[@]} - 1)))" ;;
        missing) for i in "${!T_LABEL[@]}"; do is_done "$i" || indices+="$i "; done ;;
    esac
    info "DOTFILE_PATH=$DOTFILE_PATH"
    info "package manager: $PM"
    [ -z "$indices" ] && { info "everything already done."; return; }
    for i in $indices; do run_task "$i"; done
}

# ---------------------------------------------------------------------------
# Entrypoint
# ---------------------------------------------------------------------------

MODE=interactive
for arg in "$@"; do
    case "$arg" in
        -n|--dry-run) DRY_RUN=1 ;;
        -y|--yes)     MODE=missing ;;
        -a|--all)     MODE=all ;;
        -h|--help)    sed -n '2,11p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
        *)            warn "unknown flag: $arg"; echo "Usage: $0 [-n] [-y|--all|-h]" >&2; exit 1 ;;
    esac
done

[ "$DRY_RUN" = 1 ] && info "DRY-RUN mode: no changes will be made"

case "$MODE" in
    interactive) interactive_menu ;;
    missing)     non_interactive missing ;;
    all)         non_interactive all ;;
esac

echo
if [ "$DRY_RUN" = 1 ]; then
    info "dry-run finished. re-run without -n to apply."
else
    info "open a new shell to pick up changes (or: source ~/.zshrc)"
fi
