return {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
        local formatting = require("null-ls").builtins.formatting
        return {
            sources = {
                formatting.prettier.with({
                    -- condition = function(utils)
                    --     return true
                        -- return utils.has_file({ ".prettierrc", ".prettierrc.json", ".prettierrc.yml" })
                    -- end,
                }),
                formatting.stylua,
            },
        }
    end,
}
