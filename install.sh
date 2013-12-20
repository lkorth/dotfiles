#!/bin/bash

wget -O ~/.tmux.conf https://raw.github.com/lkorth/dotfiles/master/tmux.conf
wget -O ~/.vimrc https://raw.github.com/lkorth/dotfiles/master/vimrc
wget -O ~/.gitconfig https://raw.github.com/lkorth/dotfiles/master/gitconfig

mkdir -p ~/.vim/autoload
mkdir -p ~/.vim/bundle
wget -O ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
rm -rf ~/.vim/bundle/nerdtree
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
