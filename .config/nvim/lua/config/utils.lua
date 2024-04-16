return {
    keymap = {
        opts = function(desc, bufnr)
            local opts = { noremap = true, silent = true, desc = desc }
            if bufnr then
                opts.buffer = bufnr
            end
            return opts
        end,
    },
    colorscheme = {
        default = "catppuccin-mocha",
        select = function()
            vim.ui.select({
                "nightly",
                "material",
                "material-darker",
                "material-lighter",
                "material-palenight",
                "material-oceanic",
                "material-deep-ocean",
                "gruvbox",
                "tokyonight",
                "tokyonight-day",
                "tokyonight-night",
                "tokyonight-moon",
                "tokyonight-storm",
                "catppuccin",
                "catppuccin-frappe",
                "catppuccin-latte",
                "catppuccin-mocha",
                "catppuccin-macchiato",
                "onedark",
                "kanagawa",
                "kanagawa-wave",
                "kanagawa-dragon",
                "kanagawa-lotus",
                "dracula",
                "dracula-soft",
            }, { prompt = "Select colorscheme" }, function(choice)
                vim.cmd.colorscheme(choice)
            end)
        end,
    },
    icons = {
        lspkind = {
            Text = "",
            Method = "󰆧",
            Function = "󰊕",
            Constructor = "",
            Field = "󰇽",
            Variable = "󰂡",
            Class = "󰠱",
            Interface = "",
            Module = "",
            Property = "󰜢",
            Unit = "",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󰏘",
            File = "󰈙",
            Reference = "",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰏿",
            Struct = "",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "󰅲",
        },
        diagnostics = {
            error = " ",
            warn = " ",
            info = " ",
            hint = " ",
        },
        telescope = {
            prompt_prefix = " ",
            selection_caret = " ",
        },
        git = {
            unstaged = "",
            staged = "S",
            unmerged = "",
            renamed = "➜",
            untracked = "U",
            deleted = "",
            ignored = "◌",
        },
    },
}
