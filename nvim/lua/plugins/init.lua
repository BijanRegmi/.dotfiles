local fn = vim.fn

-- Install packer if it is not installed
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
                                  install_path})
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Using protected calls to prevent errors 
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    vim.notify("Failed to require packer.")
    return
end

-- Use popup display for packer window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({
                border = "rounded"
            })
        end
    }
})

return packer.startup(function(use)

    ---------------------
    -- Package Manager --
    ---------------------
    use {"wbthomason/packer.nvim"}

    ----------------------
    -- Must have plugin --
    ----------------------
    use {"nvim-lua/plenary.nvim"}

    -----------
    -- Theme --
    -----------
    use { 'arcticicestudio/nord-vim' }

    ----------
    -- Bars --
    ----------
    use {
        {
            "vim-airline/vim-airline",
            event = 'BufEnter',
            after = 'nord-vim',
            requires = {
                'vim-airline/vim-airline-themes',
                after = 'vim-airline'
            },
            config = 'require "plugins.airline"',
        },
        {
            'akinsho/bufferline.nvim',
            tag = "v2.*",
            event = 'BufEnter',
            after = 'vim-airline',
            config = 'require "plugins.bufferline"',
        }
    }
    
    ---------------------
    -- Extra UI stuffs --
    ---------------------
    use {
        {
            'nvim-treesitter/nvim-treesitter',
            run = ":TSUpdate",
            event = 'CursorHold',
            config = 'require "plugins.treesitter"',
        },
        {
            'lewis6991/gitsigns.nvim', 
            event = 'CursorHold',
            config = 'require "plugins.gitsign"'
        }
    }

    --------------
    -- Explorer --
    --------------
    use {
        {
            "kyazdani42/nvim-tree.lua",
            tag = 'nightly',
            requires = {"kyazdani42/nvim-web-devicons"},
            cmd = {'NvimTreeFocus', 'NvimTreeToggle'},
            config = 'require "plugins.nvim-tree"'
        },
        {
            'nvim-telescope/telescope.nvim',
            tag = '0.1.0',
            cmd = 'Telescope',
            config = 'require "plugins.telescope"'
        }
    }


    ------------------
    -- Intellisense --
    ------------------
    use {
        ---------
        -- LSP --
        ---------
        {
            'williamboman/nvim-lsp-installer',
            after = 'nvim-lspconfig',
            config = 'require "plugins.LSP.installer"'
        },
        {
            'neovim/nvim-lspconfig',
            event = 'BufEnter'
        },
        {
            'hrsh7th/cmp-nvim-lsp',
            opt = true,
            after = 'nvim-lspconfig',
            config = 'require "plugins.LSP.lspconfig"'
        },
        --------------------
        -- Autocompletion --
        --------------------
        {
            'onsails/lspkind-nvim',
            opt = true,
            after = 'nvim-lspconfig',

        },
        {
            'L3MON4D3/LuaSnip',
            opt = true,
            after = 'lspkind-nvim'
        },
        {
            'hrsh7th/nvim-cmp',
            opt = true,
            after = 'LuaSnip',
            config = 'require "plugins.autocompletion"'

        },
        ---------------
        -- Formatter --
        ---------------
        {
            'jose-elias-alvarez/null-ls.nvim',
            config = 'require "plugins.formatter"'
        },
        {
            'windwp/nvim-autopairs',
            after = 'nvim-cmp',
            config = 'require "plugins.autopairs"'
        },
        ----------------
        -- Commenting --
        ----------------
        {
            'JoosepAlviste/nvim-ts-context-commentstring',
            after = 'nvim-treesitter'
        },
        {
            'numToStr/Comment.nvim',
            after = 'nvim-ts-context-commentstring',
            config = 'require "plugins.comment"'
        },
    }

    -- Trackers
    use {
        {'wakatime/vim-wakatime'},
        {'dstein64/vim-startuptime'},
        {
            'andweeb/presence.nvim',
            event = 'BufEnter',
        }
    }

    use {
        'iamcco/markdown-preview.nvim',
        run = "cd app && npm install",
        setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
        cmd = "MarkdownPreview"
    }

    ----------------
    -- ToggleTerm --
    ----------------
    use {
        "akinsho/toggleterm.nvim",
        tag = '*', 
        config = 'require "plugins.toggleterm"'
    }

    use "elkowar/yuck.vim"
    use "bhurlow/vim-parinfer"

    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
