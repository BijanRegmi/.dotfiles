call plug#begin('~/.config/nvim/autoload/plugged')

Plug 'vim-airline/vim-airline'                                                          " Status bar
Plug 'dylanaraps/wal.vim'                                                               " Pywal colourscheme
Plug 'tpope/vim-fugitive'                                                               " Git plugin
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'yarn install --frozen-lockfile'} " Code completion
Plug 'kevinhwang91/rnvimr'                                                              " File explorer

call plug#end()
