#!/bin/bash

# Setup script for installing some of the tools I use on linux
# This uses pacman as the package manager, because arch is bae

# Delete existing .gitconfig
rm ~/.gitconfig

# Creating symlink for .gitconfig
echo "Creating symlink for .gitconfig"
ln -s $PWD/.gitconfig ~/.gitconfig

# Installing ZSH
echo "Installing ZSH"
sudo pacman -S zsh --noconfirm

# Installing oh-my-zsh because it's better that way ;)
echo "Installig oh-my-zsh"
echo "Don't forget once you get into the zsh shell you need to press Ctrl + D to exit back to bash"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Delete existing .zshrc
rm ~/.zshrc

# Creating symlink for .zshrc
echo "Creating symlink for .zshrc"
ln -s $PWD/.zshrc ~/.zshrc

# Installing vim
echo "Installing vim"
sudo pacman -S vim --noconfirm

# Delete existing .vimrc
rm ~/.vimrc

# Creating symlink for .vimrc
echo "Creating synlink for .vimrc"
ln -s $PWD/.vimrc ~/.vimrc

# Installing oh-my-zim because it's better that way ;)
echo "Installing oh-my-vim"
curl -L https://raw.github.com/liangxianzhe/oh-my-vim/master/tools/install.sh | sh

# Installing vundle
echo "Installing vundle"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# Installing CtrlP fuzzy finder
git clone https://github.com/kien/ctrlp.vim.git ~/.vim/bundle/ctrlp.vim
vim -c "helptags ~/.vim/bundle/ctrlp.vim/doc" -c q

# Installing termite terminal
echo "Installing termite"
sudo pacman -S termite --noconfirm

# Creating ~/.config directory for termite
mkdir -p ~/.config/termite

 # Delete existing .termite config
rm ~/.config/termite/config 

# Creating symlink for termite config depending on laptop or not
if [ "$1" == "laptop" ]; then
    echo "Creating symlink for termite laptop config ~/.config/termite/config"
    ln -s $PWD/.config/termite/laptop-config ~/.config/termite/config 
else
    echo "Creating symlink for ~/.config/termite/config"
    ln -s $PWD/.config/termite/config ~/.config/termite/config 
fi

# Installing tmux
echo "Installing tmux"
sudo pacman -S tmux

# Installing .tmux.conf
echo "Installing .tmux.conf"
ln -s $PWD/.tmux.conf ~/.tmux.conf

# Installing fzf to replace default reverse search
echo "Installing fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

echo "Setup finished" 
