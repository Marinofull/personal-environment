"PATHOGEN"
execute pathogen#infect()
execute pathogen#helptags()

"configurações e ajustes para edição"
syntax on
filetype plugin indent on

"enable spell"
"set spell spelllang=pt,en

set t_Co=256

set number
set hlsearch

set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

colorscheme desert

"configura o plugin CtrlP"
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'rw'

"vim airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'molokai'
let g:airline#extensions#tabline#enabled = 1
set laststatus=2

"vim-gitgutter
"You can jump between hunks with [c and ]c. You can preview, stage, and revert
"hunks with <leader>hp, <leader>hs, and <leader>hr respectively.
"nmap ]h <Plug>GitGutterNextHunk
"nmap [h <Plug>GitGutterPrevHunk
set updatetime=250
let g:gitgutter_realtime = 0

"aparetly it should only ignores files in .gitignore, but I dont know what the
"hell on earth it is showing other dotfiles to, stoping in .folder that are
"submodules, and I freaking love it!!!
"let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_user_command = 'find %s -type f'

"Altera o esc para um atalho rápido mais próximo"
inoremap jk <ESC>
inoremap kj <ESC>

map W :w<CR>
