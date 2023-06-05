return {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = {
        options = {
            icons_enabled = true,
            theme = 'tokyonight',
            component_separators = '',
            section_separators = { left = '', right = '' },
            disabled_filetypes = { statusline = {}, winbar = {} },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = false,
            refresh = { statusline = 1000, tabline = 1000, winbar = 1000 }
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = {
                'branch',
                'diff',
                {
                    'diagnostics',
                    sources = { 'nvim_diagnostic' },
                    symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
                }
            },
            lualine_c = { { 'filename', path = 1 } },
            lualine_x = { { 'encoding', fmt = string.upper }, 'filetype' },
            lualine_y = { 'progress', 'location' },
            lualine_z = {},
        },
        inactive_sections = {
            lualine_a = { 'mode' },
            lualine_b = {
                'branch',
                'diff',
                {
                    'diagnostics',
                    sources = { 'nvim_diagnostic' },
                    symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
                }
            },
            lualine_c = { { 'filename', path = 1 } },
            lualine_x = { { 'encoding', fmt = string.upper }, 'filetype' },
            lualine_y = { 'progress', 'location' },
            lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = { 'nvim-tree', 'toggleterm' }
    }
}
