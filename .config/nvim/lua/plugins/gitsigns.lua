local keyopts = require("config.utils").keymap.opts

return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cmd = "Gitsigns",
    init = function()
        vim.keymap.set("n", "gbl", ":Gitsigns blame_line<CR>", keyopts("Git blame line"))
        vim.keymap.set("n", "ghp", ":Gitsigns preview_hunk<CR>", keyopts("Git preview hunk"))
        vim.keymap.set("n", "gnh", ":Gitsigns next_hunk<CR>", keyopts("Git next hunk"))
        vim.keymap.set("n", "gph", ":Gitsigns prev_hunk<CR>", keyopts("Git previous hunk"))
        vim.keymap.set("n", "gdt", ":Gitsigns diffthis<CR>", keyopts("Git diff this"))
        vim.keymap.set("n", "gsh", ":Gitsigns stage_hunk<CR>", keyopts("Git stage hunk"))
        vim.keymap.set("n", "grh", ":Gitsigns reset_hunk<CR>", keyopts("Git reset hunk"))
        vim.keymap.set("n", "grb", ":Gitsigns reset_buffer<CR>", keyopts("Git reset buffer"))
        vim.keymap.set("n", "guh", ":Gitsigns undo_stage_hunk<CR>", keyopts("Git undow stage hunk"))
        vim.keymap.set("n", "gsb", ":Gitsigns stage_buffer<CR>", keyopts("Git stage buffer"))
    end,
    opts = {
        signs = {
            untracked = { text = "▎" },
        },
        preview_config = {
            border = "rounded",
        },
    },
}
