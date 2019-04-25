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
