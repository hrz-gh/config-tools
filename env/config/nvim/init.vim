source $HOME/.vimrc

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
"       

call plug#begin('~/.config/nvim/plugged')
    Plug 'gcmt/wildfire.vim'
call plug#end()
