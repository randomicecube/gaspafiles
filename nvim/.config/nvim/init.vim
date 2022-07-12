""""""""""""""
" Vim Config "
""""""""""""""

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

set termguicolors
colorscheme gruvbox

if strftime("%H") < 8 || strftime("%H") > 19
	set background=dark
else
	set background=light
	highlight Cursor ctermfg=Black ctermbg=Black cterm=bold guifg=black guibg=black gui=bold
	highlight CursorColumn ctermfg=Black ctermbg=Black cterm=bold guifg=black guibg=black gui=bold
endif

"colorscheme tokyonight
"let g:tokyonight_style = "night"

set splitright
set splitbelow

"augroup nerdtree_open
"    autocmd!
"    autocmd VimEnter * NERDTree | wincmd p
"augroup END

""""""""""""""""""""""""""
" Markdown Preview Stuff "
""""""""""""""""""""""""""
    let g:mkdp_path_to_chrome = ""
    " Path to the chrome or the command to open chrome (or other modern browsers).
    " If set, g:mkdp_browserfunc would be ignored.

    let g:mkdp_browserfunc = 'MKDP_browserfunc_default'
    " Callback Vim function to open browser, the only parameter is the url to open.

    let g:mkdp_auto_start = 0
    " Set to 1, Vim will open the preview window on entering the Markdown
    " buffer.

    let g:mkdp_auto_open = 0
    " Set to 1, Vim will automatically open the preview window when you edit a
    " Markdown file.

    let g:mkdp_auto_close = 1
    " Set to 1, Vim will automatically close the current preview window when
    " switching from one Markdown buffer to another.

    let g:mkdp_refresh_slow = 0
    " Set to 1, Vim will just refresh Markdown when saving the buffer or
    " leaving from insert mode. With default 0, it will automatically refresh
    " Markdown as you edit or move the cursor.

    let g:mkdp_command_for_global = 0
    " Set to 1, the MarkdownPreview command can be used for all files,
    " by default it can only be used in Markdown files.

    let g:mkdp_open_to_the_world = 0
    " Set to 1, the preview server will be available to others in your network.
    " By default, the server only listens on localhost (127.0.0.1).

let g:python3_host_prog = "/usr/lib/python3.9"
