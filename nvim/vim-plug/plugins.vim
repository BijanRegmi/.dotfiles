call plug#begin('~/.config/nvim/autoload/plugged')

" Stable version of coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Onedark color scheme
Plug 'joshdick/onedark.vim'

" Auto pair completion
Plug 'jiangmiao/auto-pairs'

" Colorize hex codes
Plug 'norcalli/nvim-colorizer.lua'

" Commenter
Plug 'preservim/nerdcommenter'

" Airline
Plug 'vim-airline/vim-airline'

" Airline themes
Plug 'vim-airline/vim-airline-themes'

" Ranger
Plug 'kevinhwang91/rnvimr'

call plug#end()
