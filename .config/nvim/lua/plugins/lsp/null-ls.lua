return {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
        local formatting = require("null-ls").builtins.formatting
        return {
            sources = { formatting.prettier, formatting.stylua },
        }
    end,
}
