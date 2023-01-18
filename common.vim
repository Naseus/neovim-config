"--Commands
set wildmenu          " Show preview for comands
" wildingnore+=X           <-- sets ignore

"--No Backup
set nobackup
set nowritebackup
set noswapfile
set hidden  " buffers remain open in the background

"---Guidelines
set number relativenumber
set colorcolumn=80
set showcmd             " shows command

"---Mapping
tnoremap jk <C-\><C-n>
noremap <C-Down> <C-w>j
noremap <C-Left> <C-w>h
noremap <C-Up> <C-w>k
noremap <C-Right> <C-w>l
noremap <C-j> <C-w>j
noremap <C-h> <C-w>h
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

"---Color
syntax on
colorscheme gruvbox
set bg=dark

"---Terminal
set splitbelow
"set termsize=10x0

"---Spaces
set tabstop=2
set softtabstop=0
set shiftwidth=2
set autoindent
set showtabline=2       " Gives The file name tab type 2

"--Omnifunc
filetype plugin on
set omnifunc=syntaxcomplete#Complete

"--Misc
set ttyfast
set nowrap              " Text will not wrap
set secure
set exrc
set list
let mapleader = " " " map leader to Space
