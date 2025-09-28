return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    branch = "main",
    opts = {
        ensure_installed = "all",
        highlight = { enable = true },
        indent = { enable = true },
        autopairs = { enable = true },
    }
}
