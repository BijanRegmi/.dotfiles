return {
    'stevearc/aerial.nvim',
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
    opts = {
        on_attach = function(bufnr)
            local register_keymap = require("keybindings").register_keymap
            register_keymap('n', "<leader>a", { "<Cmd>AerialToggle!<CR>", desc = "Toogle symbols" })
            register_keymap('n', "<C-a>", { "<Cmd>Telescope aerial<CR>", desc = "Open symbols nav" })
        end
    },
}
