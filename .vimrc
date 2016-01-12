execute pathogen#infect()
syntax on
filetype plugin indent on

set t_Co=256

set number
set hlsearch

set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

set runtimepath^=~/.vim/bundle/ctrlp.vim

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

inoremap jk <ESC>
inoremap kj <ESC>

map W :w<CR>
