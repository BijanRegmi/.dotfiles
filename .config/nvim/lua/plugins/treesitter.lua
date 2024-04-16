return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    opts = {
        ensure_installed = "all",
        highlight = { enable = true },
        indent = { enable = true },
        autopairs = { enable = true },
    },
}
