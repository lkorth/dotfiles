#!/bin/bash

# get dotfiles
wget -N -O ~/.tmux.conf https://raw.github.com/lkorth/dotfiles/master/tmux.conf
wget -N -O ~/.vimrc https://raw.github.com/lkorth/dotfiles/master/vimrc
wget -N -O ~/.gitconfig https://raw.github.com/lkorth/dotfiles/master/gitconfig

# setup vim
rm -rf ~/.vim
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
cd ~/.vim/bundle/command-t/ruby/command-t
ruby extconf.rb
make
