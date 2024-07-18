return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 500
    end,
    opts = {
        win = {
            border = "rounded",
            position = "bottom",
            margin = { 0, 0, 0, 0 },
            padding = { 1, 1, 1, 1 },
            winblend = 0,
            zindex = 1000,
        },
    },
}
