call plug#begin('~/.config/nvim/autoload/plugged')

Plug 'vim-airline/vim-airline'                                                          " Status bar
Plug 'vim-airline/vim-airline-themes'                                                   " Status bar theme
Plug 'tpope/vim-fugitive'                                                               " Git plugin
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'yarn install --frozen-lockfile'} " Code completion
Plug 'arcticicestudio/nord-vim'                                                         " Nord theme
Plug 'preservim/nerdtree'                                                               " Explorer panel
Plug 'Xuyuanp/nerdtree-git-plugin'                                                      " Show git status in nerdtree
Plug 'ryanoasis/vim-devicons'                                                           " Icons
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }                                       " Top line

call plug#end()
