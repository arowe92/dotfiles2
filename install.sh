
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac
echo ${machine}

# install Zsh
if [ "$machine" -eq "Linux" ]; then
    install='sudo apt-get install -y'
fi
if [ "$machine" -eq "Mac" ]; then
    install='brew install'
fi

$install zsh
$install fasd
$install tmux
$install neovim


# install pyenv
curl https://pyenv.run | bash

# Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Antigen
curl -L git.io/antigen > ~/.oh-my-zsh/custom/antigen.zsh

dest=/tmp/dotfiles
git clone https://github.com/arowe92/dotfiles2.git $dest

# Config
mkdir -p $HOME/.config

cd $dest
mv .config/nvim $HOME/.config
mv .vimrc .zshrc .tmux.conf .gitconfig ~/

# Install N
export N_PREFIX="$HOME/.n"
export PREFIX="$HOME/.n"
curl -L https://git.io/n-install | bash

# Remove repo
rm -rf $dest

# Load it!
zsh
