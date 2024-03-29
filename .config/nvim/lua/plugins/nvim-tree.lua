return {
    "kyazdani42/nvim-tree.lua",
    tag = 'nightly',
    cmd = { 'NvimTreeFocus', 'NvimTreeToggle' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        sort_by = "case_sensitive",
        disable_netrw = true,
        sync_root_with_cwd = true,
        view = {
            adaptive_size = false,
            centralize_selection = false,
            width = 30,
            hide_root_folder = false,
            side = "left",
            preserve_window_proportions = false,
            number = false,
            relativenumber = false,
            signcolumn = "yes",
            mappings = {
                custom_only = false,
                list = {
                    { key = { "l", "<CR>", "o" }, action = "edit" },
                    { key = "<C-l>",              action = "cd" },
                    { key = "<C-h>",              action = "dir_up" },
                    { key = "h",                  action = "close_node" },
                    { key = "v",                  action = "vsplit" },
                    { key = "?",                  action = "toggle_help" },
                    { key = "<C-e>",              action = "close" }
                }
            }
        },
        diagnostics = {
            enable = true,
            show_on_dirs = true,
            icons = { hint = "", info = "", warning = "", error = "" }
        },
        renderer = {
            group_empty = true,
            root_folder_modifier = ":p",
            icons = {
                show = {
                    file = true,
                    folder = true,
                    folder_arrow = true,
                    git = true
                },
                glyphs = {
                    default = "",
                    symlink = "",
                    folder = {
                        arrow_open = "",
                        arrow_closed = "",
                        default = "",
                        open = "",
                        empty = "",
                        empty_open = "",
                        symlink = "",
                        symlink_open = ""
                    },
                    git = {
                        unstaged = "",
                        staged = "S",
                        unmerged = "",
                        renamed = "➜",
                        untracked = "U",
                        deleted = "",
                        ignored = "◌"
                    }
                }
            }
        },
        filters = { dotfiles = true },
        git = { enable = true, ignore = true, show_on_dirs = true, timeout = 400 }
    }
}
