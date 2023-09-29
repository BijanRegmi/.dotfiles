return {
    {
        "Alexis12119/nightly.nvim",
        lazy = true,
        priority = 1000,
        config = function() require('plugins.colorscheme.nightly') end,
    },

    {
        "marko-cerovac/material.nvim",
        lazy = true,
        priority = 1000,
        config = function() require('plugins.colorscheme.material') end,
    },

    {
        -- colorscheme tokyonight
        "folke/tokyonight.nvim",
        lazy = true,
        priority = 1000,
        config = function() require('plugins.colorscheme.tokyonight') end,
    },

    {
        -- colorscheme catppuccin
        "catppuccin/nvim",
        lazy = true,
        name = "catppuccin",
        priority = 1000,
        config = function() require('plugins.colorscheme.catppuccin') end,
    },

    {
        -- colorscheme onedark
        "navarasu/onedark.nvim",
        lazy = true,
        priority = 1000,
        config = function() require('plugins.colorscheme.onedark') end,
    },

    {
        -- colorscheme kanagawa
        "rebelot/kanagawa.nvim",
        lazy = true,
        priority = 1000,
        config = function() require('plugins.colorscheme.kanagawa') end,
    },

    {
        -- colorscheme dracula
        "Mofiqul/dracula.nvim",
        lazy = true,
        priority = 1000,
        config = function() require('plugins.colorscheme.dracula') end,
    },
}
