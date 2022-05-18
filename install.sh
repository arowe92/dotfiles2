#!/bin/bash
cmds=()
cmds+=("mkdir -p $HOME/.config")

output="run_install.sh"

# List of Standard packages
apt_packages=(make cmake gcc)
function apt_options () {
    for pkg in "${apt_packages[@]}"; do
        echo -n "$pkg apt-get 1 "
    done
}

# Get Location of dotfiles
dotpath="$(whiptail --inputbox 'Dotfiles Location' 0 0 $HOME/dot 3>&1 1>&2 2>&3)"
if [[ -z "$dotpath" ]]; then
    exit
fi


cmds+=("\n# Install Command")
cmds+=("alias install='sudo apt-get install -y'")

cmds+=("\n# clone")
cmds+=("git clone https://github.com/arowe92/dotfiles2.git $dotpath")

###########################
choices=$(whiptail --checklist 'CLI Utilities' 30 60 20 \
.zshrc 'RC File' 1 \
.tmux.conf 'RC File' 1 \
.vimrc 'RC File' 1 \
\
zsh 'cli tool' 1 \
fasd 'cli tool' 1 \
tmux 'cli tool' 1 \
neovim 'cli tool' 1 \
ranger 'cli tool' 1 \
starship 'cli tool' 1 \
fzf 'cli tool' 1 \
rust_tools 'cli tool' 1 \
\
$(apt_options) \
n 'Language' 0 \
atom 'App' 0 \
guake 'App' 0 \
jumpapp 'GUI Tool' 0 \
links 'Make links' 0 \
\
3>&1 1>&2 2>&3 | sed s/\"//g)

# Exit Early
if [[ -z "$choices" ]]; then
    exit
fi

if [[ "$choices" == *".zshrc"* ]]; then
    cmds+=("\n# zsh")
    cmds+=("echo 'source $dotpath/.zshrc' >> $HOME/.zshrc")
    cmds+=("echo 'source $dotpath/.config/aliases.sh' >> $HOME/.zshrc")
    cmds+=("echo 'source $dotpath/.config/functions.sh' >> $HOME/.zshrc")
    cmds+=("echo 'export PATH=\"\$PATH:$dotpath/bin\"' >> $HOME/.zshrc")
    cmds+=("echo 'export DOTFILE_PATH=\"$dotpath\"' >> $HOME/.zshrc")
fi

if [[ "$choices" == *".vimrc"* ]]; then
    cmds+=("\n# vim")
    cmds+=("echo 'source $dotpath/.vimrc' >> $HOME/.vimrc")
    cmds+=("echo 'set runtimepath+=$dotpath' >> $HOME/.vimrc")
fi

if [[ "$choices" == *" .tmux.conf "* ]]; then
    cmds+=("\n# tmux")
    cmds+=("echo 'source $dotpath/.tmux.conf' >> $HOME/.tmux.conf")
fi

if [[ "$choices" == *" zsh "* ]]; then
    # Oh-My-Zsh
    cmds+=("\n# zsh")
    cmds+=("install zsh")
    cmds+=("mv $HOME/.zshrc")
    cmds+=("git clone https://github.com/ohmyzsh/ohmyzsh.git $HOME/.oh-my-zsh")
    cmds+=("mv $HOME/.zshrc")
    cmds+=("curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh")
fi

if [[ "$choices" == *" fasd "* ]]; then
    cmds+=("\n# fasd")
    cmds+=("sudo add-apt-repository ppa:aacebedo/fasd && sudo apt-get update")
    cmds+=("install fasd")
fi

if [[ "$choices" == *" fzf "* ]]; then
    cmds+=("\n# fzf")
    cmds+=("git clone https://github.com/junegunn/fzf /tmp/fzf")
    cmds+=("cd /tmp/fzf && make install && rm -rf /tmp/fzf")
fi

if [[ "$choices" == *" tmux "* ]]; then
    cmds+=("\n# tmux")
    cmds+=("git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm")
    cmds+=("install tmux")
fi

if [[ "$choices" == *"neovim"* ]]; then
    cmds+=("mkdir -p $HOME/.config/nvim;")
    cmds+=("cp $dotpath/.config/nvim/init.vim $HOME/.config/nvim")
    cmds+=("install neovim")
fi

if [[ "$choices" == *"ranger"* ]]; then
    cmds+=("sudo apt-get -y intall caca-utils highlight atool w3m poppler-utils mediainfo")
    cmds+=("install ranger")
fi

if [[ "$choices" == *"atom"* ]]; then
    cmds+=("sudo echo \"deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main > /etc/apt/sources.list.d/atom.list")
    cmds+=("wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add - && sudo apt-get update")
fi

if [[ "$choices" == *"starship"* ]]; then
    cmds+=("\n# Starship")
    cmds+=("ln -s $dotpath/.config/starship.toml $HOME/.config/starship.toml")
    cmds+=("curl -sS https://starship.rs/install.sh | sh")
fi

if [[ "$choices" == *"rust_tools"* ]]; then
    cmds+=("\n# Rust Tools")
    curl -L git.io/antigen > antigen.zsh

    cmds+=("install ripgrep")
    cmds+=("install bat")
    cmds+=("install batcat")
    cmds+=("install fd-find")
fi

if [[ "$choices" == *"jumpapp"* ]]; then
    cmds+=("\n# jump_app")
    cmds+=("mkdir jumpapp")
    cmds+=("cd jumpapp")
    cmds+=("    sudo apt-get -y install build-essential debhelper git pandoc shunit2")
    cmds+=("    git clone https://github.com/mkropat/jumpapp.git")
    cmds+=("    cd jumpapp")
    cmds+=("        make deb")
    cmds+=("        sudo dpkg -i jumpapp*all.deb")
    cmds+=("        # if there were missing dependencies")
    cmds+=("        sudo apt-get -y install -f")
    cmds+=("    cd ..")
    cmds+=("cd ..")
    cmds+=("rm -rf jumpapp")
fi

if [[ "$choices" == *" n "* ]]; then
    # Install N
    prefix="N_PREFIX=$HOME/.n PREFIX=$HOME/.n"
    cmds+=("$prefix curl -L https://git.io/n-install | bash")
fi

###############################
# Link Dot Files
LN () {
    DIR="mkdir -p \$(dirname $HOME/$1);"
    echo "$DIR ln -s$LN_OPTS $dotpath/$1 $HOME/$1"
}

if [[ "$choices" == *"links"* ]]; then
    cmds+=("\n# links")
    cmds+=("$(LN .config/nvim/init.vim)")
    cmds+=("$(LN .config/aliases.sh)")
    cmds+=("$(LN .config/functions.sh)")
    cmds+=("$(LN .config/ranger/scope.sh)")
    cmds+=("$(LN .config/tmux/pane-left.conf)")
    cmds+=("$(LN .config/tmux/pane-up.conf)")
    cmds+=("$(LN .gitconfig)")
fi

echo "#!/bin/bash\n\n" > $output

for cmd in "${cmds[@]}"; do
    echo -e "$cmd" >> $output
done

echo "output to $output"

