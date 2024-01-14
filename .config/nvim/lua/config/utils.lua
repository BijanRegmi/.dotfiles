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
