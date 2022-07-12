if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
Plug 'andweeb/presence.nvim'
Plug 'ryanoasis/vim-devicons'
Plug 'folke/tokyonight.nvim'
Plug 'honza/vim-snippets'
Plug 'vim-airline/vim-airline'
"Plug 'scrooloose/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'morhetz/gruvbox'
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.nvim'
Plug 'pangloss/vim-javascript'
Plug 'nvim-telescope/telescope.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'famiu/feline.nvim'
Plug 'akinsho/bufferline.nvim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
call plug#end()

