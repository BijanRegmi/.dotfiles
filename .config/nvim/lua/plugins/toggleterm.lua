local keyopts = require("config.utils").keymap.opts

return {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = "ToggleTerm",
    opts = {
        open_mapping = "<C-\\>",
        autochdir = false,
        float_opts = {
            border = "rounded",
            winblend = 10,
        },
    },
    keys = { "<C-\\>", "<C-l>" },
    init = function()
        function _G.set_terminal_keymaps()
            local opts = { buffer = 0 }
            vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
        end

        vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
    end,
    config = function(_, opts)
        require("toggleterm").setup(opts)

        local Terminal = require("toggleterm.terminal").Terminal
        local lazygit = Terminal:new({
            cmd = "lazygit",
            dir = "git_dir",
            direction = "float",
        })
        function _lazygit_toggle()
            lazygit:toggle()
        end

        vim.keymap.set("n", "<C-l>", _lazygit_toggle, keyopts("Toggle lazygit"))
    end,
}
