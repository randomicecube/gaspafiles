"Misc
set tabstop=2
set shiftwidth=0
set autoindent
set hidden
set incsearch
set ruler
set wildmenu
set wildmode=longest:list,full
set number
set relativenumber

"Colorscheme - neovim-gruvbox-material from the AUR
set background=dark

if has('termguicolors')
        set termguicolors
     endif

let g:gruvbox_material_background = 'medium'

colorscheme gruvbox-material
