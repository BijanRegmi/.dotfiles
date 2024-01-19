return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
        options = {
            component_separators = "",
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = {
                "branch",
                "diff",
            },
            lualine_c = {
                {
                    "diagnostics",
                    sources = { "nvim_diagnostic" },
                    symbols = require("config.utils").icons.diagnostics,
                },
            },
            lualine_x = { { "encoding", fmt = string.upper }, "filetype" },
            lualine_y = { "progress", "location" },
            lualine_z = { { "filename", path = 1 } },
        },
        inactive_sections = {
            lualine_a = { "mode" },
            lualine_b = {
                "branch",
                "diff",
            },
            lualine_c = {
                {
                    "diagnostics",
                    sources = { "nvim_diagnostic" },
                    symbols = require("config.utils").icons.diagnostics,
                },
            },
            lualine_x = { { "encoding", fmt = string.upper }, "filetype" },
            lualine_y = { "progress", "location" },
            lualine_z = { { "filename", path = 1 } },
        },
    },
}
