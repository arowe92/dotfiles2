
# install Zsh
install='sudo apt-get install -y'
cmds=$"sudo apt-get update"
cmds=$"$cmds\nmkdir -p $HOME/.config"

dotpath="$(whiptail --inputbox 'Dotfiles Location' 0 0 $HOME/dot 3>&1 1>&2 2>&3)"
if [[ ! -z "$dotpath" ]]; then
    cmds=$"$cmds\ngit clone https://github.com/arowe92/dotfiles2.git $dotpath"
fi

# Install Atom
###########################
# CLI UTILITIES
cli_choices=$(whiptail --checklist "CLI Utilities" 0 0 0 \
zsh zsh 1 \
fasd fasd 1 \
tmux tmux 1 \
neovim neovim 1 \
fzf fzf 1 \
ranger ranger 1 3>&1 1>&2 2>&3 | sed s/\"//g)

if [[ "$cli_choices" == *"zsh"* ]]; then
    # Oh-My-Zsh
    cmds=$"$cmds\nsh -c \"\$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)\""

    # Antigen
    cmds=$"$cmds\ncurl -L git.io/antigen > $HOME/.oh-my-zsh/custom/antigen.zsh"
fi

if [[ "$cli_choices" == *"fasd"* ]]; then
    cmds=$"sudo add-apt-repository ppa:aacebedo/fasd\n$cmds"
fi

if [[ "$cli_choices" == *"tmux"* ]]; then
    cmds=$"$cmds\ngit clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm"
fi

if [[ "$cli_choices" == *"neovim"* ]]; then
    cmds=$"$cmds\nmkdir -p $HOME/.config/nvim;"
    cmds="$cmds\$ncp $dotpath/.config/nvim/init.vim $HOME/.config/nvim"
fi

if [[ "$cli_choices" == *"ranger"* ]]; then
    cli_choices="$cli_choices caca-utils highlight atool w3m poppler-utils mediainfo"
fi

cmds=$"$cmds\n$install $cli_choices"

###########################
# GUI APPS
app_choices=$(whiptail --checklist "GUI Apps" 0 0 0 \
atom atom 0 \
guake guake 0 \
 3>&1 1>&2 2>&3 | sed s/\"//g)

if [[ "$app_choices" == *"atom"* ]]; then
    cmds=$"sudo echo \"deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main > /etc/apt/sources.list.d/atom.list\n$cmds"
    cmds=$"wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -\n$cmds"
fi

if [[ ! -z "$app_choices" ]]; then
    cmds=$"$cmds\n$install $app_choices"
fi

###########################
# DEVELOPMENT LIBRARIES
dev_choices=$(whiptail --checklist "Development" 0 0 0 \
make make 1 \
cmake cmake 1 \
gcc gcc 1 \
 3>&1 1>&2 2>&3 | sed s/\"//g)

if [[ ! -z "$dev_choices" ]]; then
    cmds=$"$cmds\n$install $dev_choices"
fi

################
# Miscellaneous scripts
misc_choices=$(whiptail --checklist "Misc" 0 0 0 \
jumpapp jumpapp 0 \
n n 0 \
 3>&1 1>&2 2>&3)

if [[ "$misc_choices" == *"\"jumpapp\""* ]]; then
    cmds=$"$cmds\ninstall_jumpapp"
fi

if [[ "$misc_choices" == *"\"n\""* ]]; then
    # Install N
    prefix="N_PREFIX=$HOME/.n PREFIX=$HOME/.n"
    cmds=$"$cmds\n$prefix curl -L https://git.io/n-install | bash"
fi

###############################
# Link Dot Files
LN () {
    DIR="mkdir -p \$(dirname $HOME/$1);"
    echo "$DIR ln -s $dotpath/$1 $HOME/$1"
}

cmds=$"$cmds\n$(LN .zshrc)"
cmds=$"$cmds\n$(LN .tmux.conf)"
cmds=$"$cmds\n$(LN .vimrc)"
cmds=$"$cmds\n$(LN .config.init.vim)"
cmds=$"$cmds\n$(LN .config/aliases.sh)"
cmds=$"$cmds\n$(LN .config/functions.sh)"
cmds=$"$cmds\n$(LN .config/ranger/scope.sh)"
cmds=$"$cmds\n$(LN .gitconfig)"
cmds=$"$cmds\n$(LN .local/bin/prev)"
cmds=$"$cmds\n$(LN .local/bin/svim)"

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

echo -e $cmds > tmp.txt
while read cmd; do
    echo $cmd
    sh -c "$cmd" 1 >> log.txt
    sleep 1
done < tmp.txt

# for cmd in $cmds; do
#     echo "-----------"
#     echo -e $cmd
#     # sh -c "$cmd" 1>>log.txt
#     sleep 1
# done


