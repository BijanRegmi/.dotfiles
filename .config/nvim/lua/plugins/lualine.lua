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
            lualine_c = { { "filename", path = 1 } },
            lualine_x = { { "encoding", fmt = string.upper }, "filetype" },
            lualine_y = { "progress", "location" },
            lualine_z = {
                {
                    "diagnostics",
                    sources = { "nvim_diagnostic" },
                    symbols = require("config.utils").icons.diagnostics,
                },
            },
        },
        inactive_sections = {
            lualine_a = { "mode" },
            lualine_b = {
                "branch",
                "diff",
            },
            lualine_c = { { "filename", path = 1 } },
            lualine_x = { { "encoding", fmt = string.upper }, "filetype" },
            lualine_y = { "progress", "location" },
            lualine_z = {
                {
                    "diagnostics",
                    sources = { "nvim_diagnostic" },
                    symbols = require("config.utils").icons.diagnostics,
                },
            },
        },
    },
}
