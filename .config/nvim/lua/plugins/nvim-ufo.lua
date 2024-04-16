local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (" 󰁂 %d "):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, "MoreMsg" })
    return newVirtText
end

local keyopts = require("config.utils").keymap.opts

return {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = "BufReadPost",
    opts = {
        filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
        fold_virt_text_handler = handler,
        provider_selector = function()
            return { "lsp", "indent" }
        end,
    },
    config = function(_, opts)
        local ufo = require("ufo")
        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("local_detach_ufo", { clear = true }),
            pattern = opts.filetype_exclude,
            callback = function()
                ufo.detach()
            end,
        })
        vim.keymap.set("n", "zR", ufo.openAllFolds, keyopts("Open all folds"))
        vim.keymap.set("n", "zM", ufo.closeAllFolds, keyopts("Close all folds"))
        vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds, keyopts("Open fold except"))
        vim.keymap.set("n", "zm", ufo.closeFoldsWith, keyopts("Close folds with"))
        vim.keymap.set("n", "zp", function()
            local winid = ufo.peekFoldedLinesUnderCursor()
            if not winid then
                vim.lsp.buf.hover()
            end
        end, keyopts("Peek fold"))
        ufo.setup(opts)
    end,
}
