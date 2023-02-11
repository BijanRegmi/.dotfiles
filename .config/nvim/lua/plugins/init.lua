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
						'nvim-lualine/lualine.nvim',
						event = 'BufEnter',
						after = 'nord-vim',
						requires = { 'kyazdani42/nvim-web-devicons' },
						config = 'require "plugins.lualine"',
				},
        {
            'akinsho/bufferline.nvim',
            tag = "v2.*",
            event = 'BufEnter',
            after = 'lualine.nvim',
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
    use({
        "williamboman/mason.nvim",
        requires = {
            "williamboman/mason-lspconfig.nvim",
						{
								"jose-elias-alvarez/null-ls.nvim",
								config = 'require "plugins.formatter"'
						},
        },
    })

    use({
        "neovim/nvim-lspconfig",
        opt = true,
        event = "BufReadPre",
        config = 'require "plugins.LSP.lspconfig"',
    })



    use({
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        config = 'require "plugins.autocompletion"',
        requires = {
            { "hrsh7th/cmp-nvim-lsp" },
						{ "onsails/lspkind-nvim" },
						{ "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },
        },
    })

    use({
        "windwp/nvim-autopairs",
        after = "nvim-cmp",
        config = 'require "plugins.autopairs"',
    })

		
		use({
        "numToStr/Comment.nvim",
				config = 'require "plugins.comment"',
    })

    -- Trackers
    use {
        {'wakatime/vim-wakatime'},
        {'dstein64/vim-startuptime'},
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


	use {
		  "https://git.sr.ht/~p00f/cphelper.nvim",
		  cmd = {"Cph*"}
  }
  use {'stevearc/dressing.nvim'}

    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
