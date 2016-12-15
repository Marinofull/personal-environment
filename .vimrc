"The MIT License (MIT)
"
"Copyright (c) 2015 Marino Hohenhiem <marino@openmailbox.org, @Marinofull>
"
"Permission is hereby granted, free of charge, to any person obtaining a copy
"of this software and associated documentation files (the \"Software"), to deal
"in the Software without restriction, including without limitation the rights
"to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
"copies of the Software, and to permit persons to whom the Software is
"furnished to do so, subject to the following conditions:
"
"The above copyright notice and this permission notice shall be included in all
"copies or substantial portions of the Software.
"
"THE SOFTWARE IS PROVIDED \"AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
"IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
"FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
"AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
"LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
"OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
"SOFTWARE.


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
"highlight ExtraWhitespace ctermbg=red guibg=red
"au ColorScheme * highlight ExtraWhitespace guibg=red

"Convert tab to spaces and indent w/ same number of spaces
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

"colorscheme desert
"colorscheme ron
colorscheme koehler

"configura o plugin CtrlP"
"pelo visto n precisa mais disso em baixo quando usa o pathogen
"set runtimepath^=~/.vim/bundle/ctrlp.vim
"let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlP'
"let g:ctrlp_working_path_mode = 'rw'
"
"Prety command to search files trackeds and untrackeds by git. It stopes in folders that are
"submodules, and I freaking love it!!!
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -cox *.swp -x node_modules']
" git ls-files to list files of the repository, -c common files(tracked) -o
" (other, untracked) -x (ignore files listed) *.swp(list all .swp)

"vim airline
let g:airline_powerline_fonts = 2
let g:airline_theme = 'molokai'
"let g:airline#extensions#tabline#enabled = 1
set laststatus=2
set showtabline=2

"vim-gitgutter
"You can jump between hunks with [c and ]c. You can preview, stage, and revert
"hunks with <leader>hp, <leader>hs, and <leader>hr respectively.
"nmap ]h <Plug>GitGutterNextHunk
"nmap [h <Plug>GitGutterPrevHunk
set updatetime=250
"let g:gitgutter_realtime = 0

"Emmet setup
"type <C-e>, to activate it
let g:user_emmet_install_global = 0
autocmd FileType html,phtml,php,inc,md,mdown,css,scss EmmetInstall
"Redefining Emmet trigger key
let g:user_emmet_leader_key='<C-e>'

"vim-fugitive
"remap the Gstatus command
nnoremap <Leader>st :Gstatus<CR>
"remap the Gcommit command
nnoremap <Leader>cm :Gcommit<CR>

"Markdown to HTML
"nmap <leader>md :%!/usr/local/bin/Markdown.pl --html4tags <cr>
let g:instant_markdown_autostart = 0
nnoremap <Leader>p :InstantMarkdownPreview<CR>

" syntax
autocmd FileType html set syntax=liquid

"remap change tabs
nnoremap <C-j> :tabprevious<CR>
nnoremap <C-k> :tabnext<CR>


"snippets
"let g:UltiSnipsUsePythonVersion=2
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-g>"

"split
let g:UltiSnipsEditSplit="vertical"

"Altera o esc para um atalho rápido mais próximo"
inoremap jk <ESC>
inoremap kj <ESC>

"clean ExtraWhitespaces and save
nmap W :%s/\s\+$//e<CR>:w<CR>
