return {
    "akinsho/toggleterm.nvim",
    version = '*',
    opts = {
        size = 10,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        autochdir = false,
        shade_terminals = true,
        shading_factor = '1',
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        persist_mode = true,
        direction = 'horizontal',
        close_on_exit = true,
        shell = vim.o.shell,
        auto_scroll = true,
        float_opts = { border = 'rounded', winblend = 3 },
        winbar = {
            enabled = false,
            name_formatter = function(term) return term.name end
        }
    },
    config = function(_, opts)
        local toggleTerm = require("toggleterm")
        toggleTerm.setup(opts)

        -- Setup lazygit terminal
        local Terminal = require('toggleterm.terminal').Terminal
        local lazygit = Terminal:new({
            cmd = "lazygit",
            dir = "git_dir",
            direction = "float",
            count = 5,
            float_opts = { border = "rounded" }
        })

        function _lazygit_toggle() lazygit:toggle() end

        vim.api.nvim_set_keymap('n', "<C-l>", ":lua _lazygit_toggle()<CR>",
            { noremap = true, silent = true })
    end
}
