#!/bin/bash

# install node for coc.nvim 
curl -sL install-node.vercel.app/lts | bash 

# install tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install zsh & oh-my-zsh
sudo apt update
sudo apt install zsh
chsh -s /bin/zsh # set default shell to zsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh # install oh-my-zsh
# install zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
