
# install Zsh
install='sudo apt-get install -y'
cmds="sudo apt-get update"
cmds="$cmds\nmkdir -p $HOME/.config"

clone_location="$(whiptail --inputbox 'Dotfiles Location' 0 0 $HOME/dot 3>&1 1>&2 2>&3)"
if [[ ! -z "$clone_location" ]]; then
    cmds="$cmds\n git clone --bare https://github.com/arowe92/dotfiles2.git $clone_location"
fi

# Install Atom
#sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
cli_choices=$(whiptail --checklist "CLI Utilities" 0 0 0 \
zsh zsh 1 \
fasd fasd 1 \
tmux tmux 1 \
neovim neovim 1 \
fzf fzf 1 \
ranger ranger 1 3>&1 1>&2 2>&3 | sed s/\"//g)

if [[ "$cli_choices" == *"zsh"* ]]; then
    # Oh-My-Zsh
    cmds="$cmds\nsh -c \"\$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)\""

    # Antigen
    cmds="$cmds\ncurl -L git.io/antigen > ~/.oh-my-zsh/custom/antigen.zsh"
fi

if [[ "$cli_choices" == *"fasd"* ]]; then
    cmds="sudo add-apt-repository ppa:aacebedo/fasd\n$cmds"
fi

if [[ "$cli_choices" == *"tmux"* ]]; then
    cmds="$cmds\ngit clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm"
fi

if [[ "$cli_choices" == *"neovim"* ]]; then
    cmds="$cmds\nmkdir -p $HOME/.config/nvim;"
    cmds="$cmds\ncp $clone_location/.config/nvim/init.vim $HOME/.config/nvim"
fi

if [[ "$cli_choices" == *"ranger"* ]]; then
    cli_choices="$cli_choices caca-utils highlight atool w3m poppler-utils mediainfo"
fi


cmds="$cmds\n$install $cli_choices"

app_choices=$(whiptail --checklist "GUI Apps" 0 0 0 \
atom atom 0 \
guake guake 0 \
 3>&1 1>&2 2>&3 | sed s/\"//g)

if [[ "$app_choices" == *"atom"* ]]; then
    cmds="wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -\n$cmds"
fi

if [[ ! -z "$app_choices" ]]; then
    cmds="$cmds\n$install $app_choices"
fi

dev_choices=$(whiptail --checklist "Development" 0 0 0 \
make make 1 \
cmake cmake 1 \
gcc gcc 1 \
 3>&1 1>&2 2>&3 | sed s/\"//g)

if [[ ! -z "$dev_choices" ]]; then
    cmds="$cmds\n$install $dev_choices"
fi
#wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
#sudo apt install -y ./google-chrome-stable_current_amd64.deb
#rm ./google-chrome-stable_current_amd64.deb


misc_choices=$(whiptail --checklist "Misc" 0 0 0 \
jumpapp jumpapp 0 \
n n 0 \
 3>&1 1>&2 2>&3)

if [[ "$misc_choices" == *"\"n\""* ]]; then
    # Install N
    prefix="N_PREFIX=$HOME/.n PREFIX=$HOME/.n"
    cmds="$cmds\n$prefix curl -L https://git.io/n-install | bash"
fi

echo  -n $cmds > cmds.txt
for cmd in "$cmds"; do
    echo $cmd
done
exit

dest=/tmp/dotfiles
git clone https://github.com/arowe92/dotfiles2.git $dest



# Config
mkdir -p $HOME/.config

cd $dest
mv .config/nvim $HOME/.config
mv .vimrc .zshrc .tmux.conf .gitconfig ~/
mv .config/aliases.sh .config/functions.sh ~/.config
mv .local/bin/* $HOME/.local/bin


# Remove repo
rm -rf $dest

git clone --bare https://github.com/arowe92/dotfiles2.git $HOME/.dotfiles
git --git-dir=$HOME/.dotfiles --work-tree=$HOME config --local status.showUntrackedFiles no

# Install jumpapp
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
sudo rm -rf jumpapp
