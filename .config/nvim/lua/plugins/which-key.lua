return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 500
    end,
    opts = {
        window = {
            border = "rounded",       -- none, single, double, shadow
            position = "bottom",      -- bottom, top
            margin = { 0, 0, 0, 0 },  -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
            padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
            winblend = 0,             -- value between 0-100 0 for fully opaque and 100 for fully transparent
            zindex = 1000,            -- positive value to position WhichKey above other floating windows.
        },
    },
    config = function(_, opts)
        require("which-key").setup(opts)
        require("keybindings").which_key_register()
    end
}
