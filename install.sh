
# install Zsh
install='sudo apt-get install -y'


# Install Atom
wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'

# Fasd
sudo add-apt-repository ppa:aacebedo/fasd

sudo apt-get update

$install zsh
$install fasd
$install tmux
$install neovim
$install atom
$install make


# install pyenv
curl https://pyenv.run | bash

# Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Antigen
curl -L git.io/antigen > ~/.oh-my-zsh/plugins/antigen.zsh

dest=/tmp/dotfiles
git clone https://github.com/arowe92/dotfiles2.git $dest

# Config
mkdir -p $HOME/.config

cd $dest
mv .config/nvim $HOME/.config
mv .vimrc .zshrc .tmux.conf .gitconfig ~/
mv .config/aliases.sh .config/functions.sh ~/.config

# Install N
export N_PREFIX="$HOME/.n"
export PREFIX="$HOME/.n"
curl -L https://git.io/n-install | bash

# Remove repo
rm -rf $dest

git clone --bare https://github.com/arowe92/dotfiles2.git $HOME/.dotfiles
git --git-dir=$HOME/.dotfiles --work-tree=$HOME config --local status.showUntrackedFiles no
echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.config/aliases.sh

# Load it!
zsh
