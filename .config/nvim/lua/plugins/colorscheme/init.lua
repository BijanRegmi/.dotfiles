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
}
