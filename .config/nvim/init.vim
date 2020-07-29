set t_Co=256          " 256 color mode in term
set cc=78             " Highlight column at 78
set textwidth=78      " Wrap at column 78
map <C-x> <C-w><C-w>
map <C-o> :Neoformat<CR>

set tabstop=2         " number of visual spaces per TAB
set softtabstop=2     " number of spaces in tab when editing
set shiftwidth=2      " number of spaces to use for autoindent
set expandtab         " tabs are space
set autoindent
set copyindent        " copy indent from the previous line
set autoread          " automatically read file when it changes
set foldmethod=syntax " auto fold
set guicursor=        " don't replace the existing cursor

call plug#begin()
Plug 'ayu-theme/ayu-vim' " or other package manager
Plug 'itchyny/lightline.vim'
Plug 'sbdchd/neoformat'
call plug#end()

set termguicolors     " enable true colors support
let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme
colorscheme ayu
