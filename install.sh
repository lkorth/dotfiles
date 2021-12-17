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
curl https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy --output ~/.bin/diff-so-fancy
chmod +x ~/.bin/diff-so-fancy
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.bin/zsh-syntax-highlighting

# setup vim
rm -rf ~/.vim
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
