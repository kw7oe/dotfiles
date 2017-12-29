if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" ==============
" General Plugin
" ==============

" Vim-Fugitive: Git Wrapper
Plugin 'tpope/vim-fugitive'
" Fuzzy file, buffer, mru, tag etc finder
Plugin 'ctrlpvim/ctrlp.vim'
" A Tree Explorer Plugin
Plugin 'scrooloose/nerdtree'
" Perform all your vim insert mode completions with Tab
Plugin 'ervandew/supertab'
" Vim Plugin for intensely orgasmic commenting
Plugin 'scrooloose/nerdcommenter'
" A light and configurable statusline/tabline
Plugin 'itchyny/lightline.vim'
" True Sublime Text style multiple selections for Vim
" Plugin 'terryma/vim-multiple-cursors'
" A Vim plugin which shows a git diff in the gutter
Plugin 'airblade/vim-gitgutter'
" Base16
Plugin 'chriskempson/base16-vim'

" ===============
" Language Plugin
" ===============

" Elixir
Plugin 'elixir-editors/vim-elixir'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
colorscheme base16-eighties

inoremap <Left>  <NOP>
inoremap <Right> <NOP>
inoremap <Up>    <NOP>
inoremap <Down>  <NOP>

nnoremap <Left>  <NOP>
nnoremap <Right> <NOP>
nnoremap <Up>    <NOP>
nnoremap <Down>  <NOP>

imap jj <Esc>

" Ctrl + n to toggle NERDTree
map <C-n> :NERDTreeToggle<CR>
" Remove whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" =======
" General
" =======
syntax on
set number
set wildmenu
set ruler
set hid
set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw
set magic
set showmatch
set mat=2
set foldcolumn=1

" ==============
" Tab and Indent
" ==============
set expandtab "Use spaces instead of tabs
set smarttab "Be smart when using tabs
set autoindent "Auto Indent
set smartindent "Smart Indent
set wrap "Wrap lines
set shiftwidth=2
set tabstop=2

" ===========
" Status Line
" ===========
set laststatus=2
