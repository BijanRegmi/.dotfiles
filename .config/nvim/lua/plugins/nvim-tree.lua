local utils = require("config.utils")
local keyopts = utils.keymap.opts
local icons = utils.icons

return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    version = "*",
    cmd = "NvimTreeToggle",
    init = function(_)
        vim.keymap.set("n", "<C-e>", ":NvimTreeToggle<CR>", keyopts("Toggle nvim tree"))
    end,
    opts = {
        on_attach = function(bufnr)
            local api = require("nvim-tree.api")

            api.config.mappings.default_on_attach(bufnr)

            vim.keymap.set("n", "h", api.node.navigate.parent_close, keyopts("Close Directory", bufnr))
            vim.keymap.set("n", "l", api.node.open.edit, keyopts("Open", bufnr))
            vim.keymap.del("n", "<C-e>", { buffer = bufnr })
        end,
        renderer = {
            icons = {
                glyphs = {
                    git = icons.git,
                },
            },
        },
    },
}
