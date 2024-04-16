return {
    "numToStr/Comment.nvim",
    dependencies = {
        {
            "JoosepAlviste/nvim-ts-context-commentstring",
            opts = { enable_autocmd = false },
        },
    },
    event = "BufRead",
    opts = {
        ignore = "^$",
    },
    config = function(_, opts)
        require("Comment").setup({
            ignore = opts.ignore,
            pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        })
    end,
}
