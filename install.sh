#!/bin/bash

# symlink dotfiles
ln -s $(pwd)/tmux.conf ~/.tmux.conf
ln -s $(pwd)/goaccessrc ~/.goaccessrc
ln -s $(pwd)/zshrc ~/.zshrc
ln -s $(pwd)/vimrc ~/.vimrc
ln -s $(pwd)/gitconfig ~/.gitconfig

# setup .bin directory
rm -rf ~/.bin
mkdir ~/.bin
cp -r bin/* ~/.bin
wget -O ~/.bin/diff-so-fancy https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
chmod +x ~/.bin/diff-so-fancy

# setup vim
rm -rf ~/.vim
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
