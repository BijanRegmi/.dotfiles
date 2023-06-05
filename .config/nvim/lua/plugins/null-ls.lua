return {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
        local formatting = require("null-ls").builtins.formatting
        return { debug = true, sources = { formatting.prettier, formatting.black } }
    end
}
