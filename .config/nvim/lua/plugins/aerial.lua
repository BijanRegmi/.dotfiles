local keyopts = require("config.utils").keymap.opts

return {
    "stevearc/aerial.nvim",
    event = "BufRead",
    cmd = "AerialToggle",
    init = function()
        vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>", keyopts("Toggle Aerial"))
    end,
    config = true,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
}
