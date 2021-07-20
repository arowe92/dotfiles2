
cmds=()
pre_cmds=()
pre_cmds+=("mkdir -p $HOME/.config")


# List of apt-get installs
apt=""

# List of Standard packages
apt_packages=(make cmake gcc fzf)
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
\
$(apt_options) \
n 'Language' 0 \
atom 'App' 0 \
guake 'App' 0 \
jumpapp 'GUI Tool' 0 \
links 'Make links' 1 \
\
3>&1 1>&2 2>&3 | sed s/\"//g)

# Exit Early
if [[ -z "$choices" ]]; then
    exit
fi

if [[ "$choices" == *".zshrc"* ]]; then
    cmds+=("echo 'source $dotpath/.zshrc' >> $HOME/.zshrc")
    cmds+=("echo 'source $dotpath/.config/aliases.sh' >> $HOME/.zshrc")
    cmds+=("echo 'source $dotpath/.config/functions.sh' >> $HOME/.zshrc")
    cmds+=("echo 'export PATH=\"\$PATH:$dotpath/bin\"' >> $HOME/.zshrc")
    cmds+=("echo 'export DOTFILE_PATH=\"$dotpath\"' >> $HOME/.zshrc")
fi

if [[ "$choices" == *".vimrc"* ]]; then
    cmds+=("echo 'source $dotpath/.vimrc' >> $HOME/.vimrc")
    cmds+=("echo 'set runtimepath+=$dotpath' >> $HOME/.vimrc")
fi

if [[ "$choices" == *" .tmux.conf "* ]]; then
    cmds+=("echo 'source $dotpath/.tmux.conf' >> $HOME/.tmux.conf")
fi

if [[ "$choices" == *" zsh "* ]]; then
    # Oh-My-Zsh
    cmds+=("mv $HOME/.zshrc $HOME/.zshrc_pre")
    cmds+=("sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)\"")
    cmds+=("mv $HOME/.zshrc_pre $HOME/.zshrc")
    apt+=(zsh)
fi

if [[ "$choices" == *" fasd "* ]]; then
    pre_cmds+=("sudo add-apt-repository ppa:aacebedo/fasd")
    apt+=(fasd)
fi

if [[ "$choices" == *" tmux "* ]]; then
    cmds+=("git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm")
    apt+=(tmux)
fi

if [[ "$choices" == *"neovim"* ]]; then
    cmds+=("mkdir -p $HOME/.config/nvim;")
    cmds+=("cp $dotpath/.config/nvim/init.vim $HOME/.config/nvim")
    apt+=(neovim)
fi

if [[ "$choices" == *"ranger"* ]]; then
    apt+=(caca-utils highlight atool w3m poppler-utils mediainfo)
    apt+=(ranger)
fi

if [[ "$choices" == *"atom"* ]]; then
    pre_cmds+=("sudo echo \"deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main > /etc/apt/sources.list.d/atom.list")
    pre_cmds+=("wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -")
fi

if [[ "$choices" == *"jumpapp"* ]]; then
    cmds+=("install_jumpapp")
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
    cmds+=("$(LN .config/nvim/init.vim)")
    cmds+=("$(LN .config/aliases.sh)")
    cmds+=("$(LN .config/functions.sh)")
    cmds+=("$(LN .config/ranger/scope.sh)")
    cmds+=("$(LN .config/tmux/pane-left.conf)")
    cmds+=("$(LN .config/tmux/pane-up.conf)")
    cmds+=("$(LN .gitconfig)")
fi

# Install jumpapp
install_jumpapp() {
    mkdir jumpapp
    cd jumpapp
        sudo apt-get -y install build-essential debhelper git pandoc shunit2
        git clone https://github.com/mkropat/jumpapp.git
        cd jumpapp
            make deb
            sudo dpkg -i jumpapp*all.deb
            # if there were missing dependencies
            sudo apt-get -y install -f
        cd ..
    cd ..
    rm -rf jumpapp
}

# Add Apt packages
arr=($choices)
for choice in "${arr[@]}"; do
    if [[ " ${apt_packages[@]} " =~ " ${choice} " ]]; then
        apt+=("$choice")
    fi
done

all_cmds+=("${pre_cmds[@]}")

# Add Apt-Get Installs
if [[ ! -z "${apt[@]}" ]]; then
    install="sudo apt-get install -y ${apt[@]}"
    all_cmds+=("sudo apt-get update")
    all_cmds+=("$install")
fi

all_cmds+=("${cmds[@]}")

for cmd in "${all_cmds[@]}"; do
    echo $cmd
    if [[ ! "$1" == "--dry-run" ]]; then
        sh -c "$cmd" >> log.txt
    fi
done

