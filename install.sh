#!/bin/env zsh
DP="${0:a:h:h}"

echo "export \$DOTFILE_PATH=$DP" >> ~/.zshrc
echo "source \$DOTFILE_PATH/zsh/init.zsh" >> ~/.zshrc
echo "source $DP/config/tmux.conf" >> ~/.tmux.conf
