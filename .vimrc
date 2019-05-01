set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Install markdown plugin
Plugin 'JamshedVesuna/vim-markdown-preview'
let vim_markdown_preview_github=1
let vim_markdown_preview_hotkey='<C-k>'

" Installing surround.vim plugin
Plugin 'tpope/vim-surround'

" This is the oh my vim directory
let $OH_MY_VIM="/home/byte/.oh-my-vim"
let &runtimepath=substitute(&runtimepath, '^', $OH_MY_VIM.",", 'g')

" Select the packages you need
let g:oh_my_vim_packages=[
            \'vim',
            \'basic',
            \'code', 
            \'text', 
            \'grep', 
            \'searching', 
            \'registers', 
            \'navigation', 
            \'files', 
            \'git', 
            \'python', 
            \'web',
            \'tools', 
            \'markdown', 
            \'bookmarks', 
            \'sessions', 
            \'spelling',
            \'neobundle', 
            \'golang'
            \]

exec ':so ' $OH_MY_VIM."/vimrc"

" Use CtrlP for fuzzy finding
set runtimepath^=~/.vim/bundle/ctrlp.vim

" Disable wrapping
set nowrap
set textwidth=0
set wrapmargin=0

" Enable mouse clicks
set mouse=a
