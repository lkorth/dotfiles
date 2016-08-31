#!/bin/bash

# symlink dotfiles
ln -s $(pwd)/tmux.conf ~/.tmux.conf
ln -s $(pwd)/goaccessrc ~/.goaccessrc
ln -s $(pwd)/zshrc ~/.zshrc
ln -s $(pwd)/vimrc ~/.vimrc
ln -s $(pwd)/gitconfig ~/.gitconfig

# create .bin directory
rm -rf ~/.bin
mkdir ~/.bin
cp -r bin/* ~/.bin

# setup vim
rm -rf ~/.vim
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
