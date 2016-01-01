#!/bin/bash

# symlink dotfiles
ln -s $(pwd)/tmux.conf ~/.tmux.conf
ln -s $(pwd)/zshrc ~/.zshrc
ln -s $(pwd)/vimrc ~/.vimrc
ln -s $(pwd)/gitconfig ~/.gitconfig

# setup vim
rm -rf ~/.vim
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
