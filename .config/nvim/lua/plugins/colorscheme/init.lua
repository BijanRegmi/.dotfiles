return {
    {
        "Alexis12119/nightly.nvim",
        lazy = true,
        priority = 1000,
        opts = require("plugins.colorscheme.nightly"),
    },
    {
        "marko-cerovac/material.nvim",
        lazy = true,
        priority = 1000,
        opts = require("plugins.colorscheme.nightly"),
    },
    {
        -- colorscheme tokyonight
        "folke/tokyonight.nvim",
        lazy = true,
        priority = 1000,
        opts = require("plugins.colorscheme.tokyonight"),
    },
    {
        -- colorscheme catppuccin
        "catppuccin/nvim",
        lazy = true,
        name = "catppuccin",
        priority = 1000,
        opts = require("plugins.colorscheme.catppuccin"),
    },
    {
        -- colorscheme onedark
        "navarasu/onedark.nvim",
        lazy = true,
        priority = 1000,
        opts = require("plugins.colorscheme.onedark"),
    },
    {
        -- colorscheme kanagawa
        "rebelot/kanagawa.nvim",
        lazy = true,
        priority = 1000,
        opts = require("plugins.colorscheme.kanagawa"),
    },
    {
        -- colorscheme dracula
        "Mofiqul/dracula.nvim",
        lazy = true,
        priority = 1000,
        opts = require("plugins.colorscheme.dracula"),
    },
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = true,
        opts = require("plugins.colorscheme.gruvbox"),
    },
    {
        "tiagovla/tokyodark.nvim",
        priority = 1000,
        config = true,
        opts = require("plugins.colorscheme.tokyodark"),
    },
    {
        "shaunsingh/nord.nvim",
        priority = 1000,
        opts = require("plugins.colorscheme.nord"),
        config = function(_, opts)
            vim.g.nord_contrast = true
            vim.g.nord_borders = false
            vim.g.nord_disable_background = false
            vim.g.nord_italic = false
            vim.g.nord_uniform_diff_background = true
            vim.g.nord_bold = false
        end
    }
}
