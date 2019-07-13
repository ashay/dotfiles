set t_Co=256          " 256 color mode in term
set cc=78             " Highlight column at 78
set textwidth=78      " Wrap at column 78
map <C-x> <C-w><C-w>

set tabstop=2         " number of visual spaces per TAB
set softtabstop=2     " number of spaces in tab when editing
set shiftwidth=2      " number of spaces to use for autoindent
set expandtab         " tabs are space
set autoindent
set copyindent        " copy indent from the previous line
set autoread          " automatically read file when it changes
set foldmethod=syntax " auto fold

call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
call plug#end()

colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard'
set background=dark
set t_ut=
