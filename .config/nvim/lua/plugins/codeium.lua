return {
    "Exafunction/codeium.vim",
    event = "InsertEnter",
    config = function()
        local opts = { expr = true, silent = true }
        vim.keymap.set("i", "<A-l>", function()
            return vim.fn["codeium#Accept"]()
        end, opts)
        vim.keymap.set("i", "<A-n>", function()
            return vim.fn["codeium#CycleCompletions"](1)
        end, opts)
        vim.keymap.set("i", "<A-p>", function()
            return vim.fn["codeium#CycleCompletions"](-1)
        end, opts)
    end,
}
