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
" Perform all your vim insert mode completions with Tab
Plugin 'ervandew/supertab'
" commentary.vim: comment stuff out
Plugin 'tpope/vim-commentary'
" surround.vim: quoting/parenthesizing made simple
Plugin 'tpope/vim-surround'
" A light and configurable statusline/tabline
Plugin 'itchyny/lightline.vim'
" A Vim plugin which shows a git diff in the gutter
Plugin 'airblade/vim-gitgutter'
" Base16
Plugin 'chriskempson/base16-vim'
" Delete buffer without closing split
Plugin 'qpkorr/vim-bufkill'
" Markdown for Vim: a complete environment to create
" Markdown files with a syntax highlight that doesn't suck!
" Plugin 'gabrielelana/vim-markdown'

" ===============
" Language Plugin
" ===============

" Elixir
Plugin 'elixir-editors/vim-elixir'
" JavaScript
Plugin 'pangloss/vim-javascript'
" React
Plugin 'mxw/vim-jsx'
" Vue
Plugin 'posva/vim-vue'
" Emmet
Plugin 'mattn/emmet-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" ============
" Color Scheme
" ============

" if has("termguicolors")
" set termguicolors
" endif
" colorscheme base16-eighties
" let base16colorspace=256

" =====
" Remap
" =====
inoremap <Left>  <NOP>
inoremap <Right> <NOP>
inoremap <Up>    <NOP>
inoremap <Down>  <NOP>

nnoremap <Left>  <NOP>
nnoremap <Right> <NOP>
nnoremap <Up>    <NOP>
nnoremap <Down>  <NOP>

imap jj <Esc>

" Ctrl + n to toggle netrw
map <C-n> :Lexplore<CR>
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
set wrap "Wrap line
set textwidth=79
set shiftwidth=2
set tabstop=2

" ===========
" Status Line
" ===========
set laststatus=2

" =====
" netrw
" =====

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 25

" =====================
" Plugins Configuration
" =====================

" Ctrl P
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" vim-jsx
let g:jsx_ext_required = 0
