return {
    contrast = {
        -- Enable contrast for the built-in terminal
        terminal = false,
        -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
        sidebars = false,
        -- Enable contrast for floating windows
        floating_windows = false,
        -- Enable darker background for the cursor line
        cursor_line = false,
        -- Enable darker background for non-current windows
        non_current_windows = false,
        -- Specify which filetypes get the contrasted (darker) background
        filetypes = {},
    },
    styles = {
        comments = {},
        strings = {},
        keywords = {},
        functions = {},
        variables = {},
        operators = {},
        types = {},
    },
    plugins = {
        -- Available plugins:
        -- "dap",
        "dashboard",
        "gitsigns",
        -- "hop",
        "indent-blankline",
        -- "lspsaga",
        -- "mini",
        -- "neogit",
        "nvim-cmp",
        -- "nvim-navic",
        "nvim-tree",
        "nvim-web-devicons",
        -- "sneak",
        "telescope",
        -- "trouble",
        "which-key",
    },
    disable = {
        colored_cursor = false, -- Disable the colored cursor
        borders = false,  -- Disable borders between verticaly split windows
        background = false, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
        term_colors = false, -- Prevent the theme from setting terminal colors
        eob_lines = false, -- Hide the end-of-buffer lines
    },
    high_visibility = {
        lighter = false,    -- Enable higher contrast text for lighter style
        darker = false,     -- Enable higher contrast text for darker style
    },
    lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )
    async_loading = true,   -- Load parts of the theme asyncronously for faster startup (turned on by default)
    custom_colors = nil,    -- If you want to everride the default colors, set this to a function
    custom_highlights = {}, -- Overwrite highlights with your own
}
