return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        ensure_installed = "all",
        ignore_install = { "" },
        highlight = { enable = true },
        autopairs = { enable = true },
        indent = { enable = true },
        context_commentstring = { enable = true, enable_autocmd = false }
    }
}
