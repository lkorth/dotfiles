#!/bin/bash

wget -N -O ~/.tmux.conf https://raw.github.com/lkorth/dotfiles/master/tmux.conf
wget -N -O ~/.vimrc https://raw.github.com/lkorth/dotfiles/master/vimrc
wget -N -O ~/.gitconfig https://raw.github.com/lkorth/dotfiles/master/gitconfig

mkdir -p ~/.vim/autoload
mkdir -p ~/.vim/bundle
wget -N -O ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
rm -rf ~/.vim/bundle/nerdtree
rm -rf ~/.vim/bundle/tcomment
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
git clone https://github.com/tomtom/tcomment_vim.git ~/.vim/bundle/tcomment
