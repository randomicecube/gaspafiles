"Misc

source $HOME/.config/nvim/vim-plug/plugins.vim

set tabstop=2
set showmatch
set ignorecase
set cc=80
set shiftwidth=0
set autoindent
set hidden
set incsearch
set ruler
set wildmenu
set wildmode=longest:list,full
set number
set relativenumber
set cursorline

syntax enable
syntax on

set background=dark

if has('termguicolors')
	set termguicolors
endif

colorscheme embark

set splitright
set splitbelow

augroup nerdtree_open
    autocmd!
    autocmd VimEnter * NERDTree | wincmd p
augroup END

let g:python3_host_prog = "/usr/lib/python3.9"
