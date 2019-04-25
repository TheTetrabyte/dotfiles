#!/bin/bash

# Setup script for installing some of the tools I use on linux
# This uses pacman as the package manager, because arch is bae

# Creating symlink for .gitconfig
echo "Creating symlink for .gitconfig"
ln -s $PWD/.gitconfig ~/.gitconfig

# Installing ZSH
echo "Installing ZSH"
sudo pacman -S zsh --noconfirm

# Installing oh-my-zsh because it's better that way ;)
echo "Installig oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Creating symlink for .zshrc
echo "Creating symlink for .zshrc"
ln -s $PWD/.zshrc ~/.zshrc

# Installing vim
echo "Installing vim"
sudo pacman -S vim --noconfirm

# Creating symlink for .vimrc
echo "Creating synlink for .vimrc"
ln -s $PWD/.vimrc ~/.vimrc

# Installing oh-my-zim because it's better that way ;)
echo "Installing oh-my-vim"
curl -L https://raw.github.com/liangxianzhe/oh-my-vim/master/tools/install.sh | sh

# Installing termite terminal
echo "Installing termite"
sudo pacman -S termite --noconfirm

# Creating ~/.config directory for termite
mkdir -p ~/.config/termite

# Creating symlink for termite config
echo "Creating symlink for ~/.config/termite/config"
ln -s $PWD/.config/termite/config ~/.config/termite/config

echo "Setup finished"
