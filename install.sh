#!/bin/bash

# symlink dotfiles
ln -s $(pwd)/tmux.conf ~/.tmux.conf
ln -s $(pwd)/goaccessrc ~/.goaccessrc
ln -s $(pwd)/zshrc ~/.zshrc
ln -s $(pwd)/vimrc ~/.vimrc
ln -s $(pwd)/gitconfig ~/.gitconfig
ln -s $(pwd)/gitignore ~/.gitignore

# setup .bin directory
rm -rf ~/.bin
mkdir ~/.bin
cp -r bin/* ~/.bin
wget -O ~/.bin/diff-so-fancy https://github.com/so-fancy/diff-so-fancy/releases/download/v1.4.4/diff-so-fancy
chmod +x ~/.bin/diff-so-fancy
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.bin/zsh-syntax-highlighting

# setup vim
rm -rf ~/.vim
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
