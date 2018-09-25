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

" fix meta-keys which generate <Esc>a .. <Esc>z on gnome terminal
set <A-k>=k
set <A-j>=j
nmap k <A-k>
nmap j <A-j>
vmap k <A-k>
vmap j <A-j>

" give imode the arrows vim
imap <C-h> OD
imap <C-j> OB
imap <C-l> OC
imap <C-k> OA

"to make CTRL-A and CTRL-X work on non-alphanumeric ASCII values.
set nrformats+=alpha
set tabpagemax=20

"enable spell"
"set spell spelllang=pt,en

set t_Co=256
set fileencodings+=utf-8
set encoding=utf-8

set nu
set relativenumber
set noic "don't ignore letter case, ex. in searching
set colorcolumn=100
"highlight ExtraWhitespace ctermbg=red guibg=red
"au ColorScheme * highlight ExtraWhitespace guibg=red

"Convert tab to spaces and indent w/ same number of spaces
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
"retab

set undofile "persistent undo
set undodir=~/.vim/undodir

"colorscheme desert
"colorscheme ron
colorscheme koehler

"configura o plugin CtrlP"
"Prety command to search files trackeds and untrackeds by git. It stopes in folders that are
"submodules, and I freaking love it!!!
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -cox *.swp -x node_modules -x tmp -x vendor -x log -x public']
" git ls-files to list files of the repository, -c common files(tracked) -o
" (other, untracked) -x (ignore files listed) *.swp(list all .swp)

"vim airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'qwq'
"let g:airline#extensions#tabline#enabled = 1
set laststatus=2
set showtabline=2

"vim-gitgutter
"You can jump between hunks with [c and ]c. You can preview, stage, and revert
"hunks with <leader>hp, <leader>hs, and <leader>hr respectively.
set updatetime=250

"easy-motion
nmap /         <Plug>(easymotion-sn)
omap /         <Plug>(easymotion-sn)
xmap /         <Plug>(easymotion-sn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

" Move to line
map <Leader>l <Plug>(easymotion-bd-jk)
nmap <Leader>l <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

let g:EasyMotion_smartcase = 1

"Emmet setup
"type <C-e>, to activate it
let g:user_emmet_install_global = 0
"Redefining Emmet trigger key
let g:user_emmet_leader_key='<C-e>'
autocmd FileType html,phtml,php,eruby,inc,md,mdown,css,scss EmmetInstall

"vim-fugitive
"remap the Gstatus command
nnoremap <Leader>st :Gstatus<CR>
"remap the Gcommit command
nnoremap <Leader>cm :Gcommit<CR>

"Markdown to HTML
"nmap <leader>md :%!/usr/local/bin/Markdown.pl --html4tags <cr>
let g:instant_markdown_autostart = 0
nnoremap <Leader>m :InstantMarkdownPreview<CR>

" syntax
autocmd FileType html set syntax=liquid
autocmd BufNewFile,BufReadPost *.axlsx set filetype=ruby
autocmd BufNewFile,BufReadPost *.ino set filetype=cpp

"remap change tabs
nnoremap <C-j> :tabprevious<CR>
nnoremap <C-k> :tabnext<CR>
nnoremap g<C-j> :tabm -1<CR>
nnoremap g<C-k> :tabm +1<CR>


"snippets
"let g:UltiSnipsUsePythonVersion=2
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-g>"

"split
let g:UltiSnipsEditSplit="vertical"

"My functions
"===========

"rename a file and still in the same buffer
"If the file is versioned by Git and you have vim-fugitive, a better way is use:
":Gmove new_name
"In case it wasnt yet added to git repo type a :Gwrite before
function Hrename(var)
    let old_name = expand('%')
    let new_name = a:var
    if new_name != '' && new_name != old_name
        bd
        execute "!mv ".old_name." ".new_name
        execute "e ".new_name
    endif
endfunction

command! -nargs=1 -complete=file Hrename :call Hrename(<f-args>)

command! Spellit execute "set spell spelllang=en,pt"

" Personal macro used in opening PR using hub cli
let @c = 'dddf:.4~f-l~:s/-/ /gf r-ojjo'
" Personal macro to turn a {} block in a do end in ruby fixing the contained  code
let @d = 'vi{yda{beladoendjjO0jj=='
" turn do end block in a {}
let @f = '?dodwa{[3~jj/endnndwa}jjV%J'
" turn CamelCalse to snake_case
let @l='viwþs/\([A-Z]\)/_\L\1/g^M^Odl'

" change p from ""p to "0p and never lose lasp pasted thing
nnoremap <leader>p "0p
vnoremap <leader>p "0p
nnoremap <leader>P "0P
vnoremap <leader>P "0P

"Altera o esc para um atalho rápido mais próximo"
inoremap jj <ESC>
"Altera colon para AltGr p
nmap þ :
vmap þ :

"clean ExtraWhitespaces and save
nmap W :%s/\s\+$//e<CR>:w<CR>
nmap Q <C-w>q
