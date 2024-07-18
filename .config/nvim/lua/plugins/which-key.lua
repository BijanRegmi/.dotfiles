return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 500
    end,
    opts = {
        win = {
            no_overlap = true,
            border = "rounded",
            padding = { 1, 1, 1, 1 },
            title = true,
            title_pos = "center",
            zindex = 1000,
            bo = {},
            wo = {
              winblend = 0, 
            },
        },
    }
}
