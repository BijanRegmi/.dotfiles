call plug#begin('~/.config/nvim/autoload/plugged')

Plug 'vim-airline/vim-airline'                                                          " Status bar
Plug 'vim-airline/vim-airline-themes'                                                   " Status bar theme
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }                                       " Top line

Plug 'neovim/nvim-lspconfig'                                                            " Neovim native language server protocol support

Plug 'hrsh7th/nvim-cmp'                                                                 " Autocompletion engine
Plug 'hrsh7th/cmp-nvim-lsp'                                                             " Dependency of nvim-cmp
Plug 'L3MON4D3/LuaSnip'                                                                 " Autocomplete snippets
Plug 'saadparwaiz1/cmp_luasnip'                                                         " Snippets completion source
Plug 'onsails/lspkind-nvim'                                                             " Autocompletion icons
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }                           " Syntax highlighting

Plug 'arcticicestudio/nord-vim'                                                         " Nord theme
Plug 'ryanoasis/vim-devicons'                                                           " Icons

Plug 'preservim/nerdtree'                                                               " Explorer panel
Plug 'Xuyuanp/nerdtree-git-plugin'                                                      " Show git status in nerdtree
Plug 'tpope/vim-fugitive'                                                               " Git plugin

call plug#end()
