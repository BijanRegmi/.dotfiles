return {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function(_, opts)
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        --[[ local keybindings = require "keybindings" ]]
        --[[ keybindings.register_keymap('n', "<C-f>", { ":Telescope find_files<CR>", desc = "Telescope find files" }) ]]
        --[[ keybindings.register_keymap('n', "<C-g>", { ":Telescope live_grep<CR>", desc = "Telescope live grep" }) ]]
        --[[ keybindings.register_keymap('n', "<C-a>", { "<Cmd>Telescope aerial<CR>", desc = "Open symbols nav" }) ]]

        telescope.setup({
            defaults = {
                prompt_prefix = " ",
                selection_caret = " ",
                mappings = {
                    i = {
                        ["<C-h>"] = "which_key",
                        ["<C-f>"] = actions.close,
                        ["<A-j>"] = actions.preview_scrolling_down,
                        ["<A-k>"] = actions.preview_scrolling_up,
                        ["<C-\\>"] = actions.select_vertical,
                        ["<C-->"] = actions.select_horizontal,
                        ["<C-t>"] = actions.select_tab,
                        ["<C-u>"] = false, -- C-u clears the prompt
                        ["<C-s>"] = actions.cycle_previewers_next,
                        ["<C-a>"] = actions.cycle_previewers_prev
                    },
                    n = {
                        ["esc"] = actions.close,
                        ["<C-\\>"] = actions.select_vertical,
                        ["<C-->"] = actions.select_horizontal,
                        ["<C-t>"] = actions.select_tab,
                        ["H"] = actions.move_to_top,
                        ["J"] = actions.move_selection_next,
                        ["K"] = actions.move_selection_previous,
                        ["L"] = actions.move_to_bottom,
                        ["M"] = actions.move_to_middle,
                        ["<A-j>"] = actions.preview_scrolling_down,
                        ["<A-k>"] = actions.preview_scrolling_up
                    }
                }
            },
            pickers = { find_files = { theme = "dropdown", hidden = true } },
            extensions = {}
        })
    end
}
