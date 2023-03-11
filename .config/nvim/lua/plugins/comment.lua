return {
    "numToStr/Comment.nvim",
    dependencies = {'JoosepAlviste/nvim-ts-context-commentstring'},
    config = function(_, opts)
        local comment = require("Comment")
        local utils = require("Comment.utils")
        local tsccu = require('ts_context_commentstring.utils')
        local tscci = require('ts_context_commentstring.internal')

        comment.setup({
            padding = true,
            sticky = true,
            ignore = nil,
            toggler = {line = 'gcc', block = 'gbc'},
            opleader = {line = 'gc', block = 'gb'},
            extra = {above = 'gcO', below = 'gco', eol = 'gcA'},
            mappings = {basic = true, extra = true, extended = false},
            pre_hook = function(ctx)
                local location = nil

                if ctx.ctype == utils.ctype.block then
                    location = tsccu.get_cursor_location()
                elseif ctx.cmotion == utils.cmotion.v or ctx.cmotion ==
                    utils.cmotion.V then
                    location = tsccu.get_visual_start_location()
                end

                return tscci.calculate_commentstring {
                    key = ctx.ctype == utils.ctype.line and "__default" or
                        "__multiline",
                    location = location
                }
            end,
            post_hook = nil
        })
    end

}
