return {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = {
        options = {
            icons_enabled = true,
            theme = 'nord',
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
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = { { 'filename', path = 1 } },
            lualine_x = { { 'encoding', fmt = string.upper }, 'filetype' },
            lualine_y = { 'progress', 'location' },
            lualine_z = { { 'diagnostics', sources = { 'nvim_diagnostic' } } }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = { 'nvim-tree', 'toggleterm' }
    }
}
