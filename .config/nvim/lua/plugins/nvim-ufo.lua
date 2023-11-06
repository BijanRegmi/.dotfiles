local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (' 󰁂 %d '):format(endLnum - lnum)
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
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, 'MoreMsg' })
    return newVirtText
end

return {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    event = "BufReadPost",
    opts = {
        filetype_exclude = { 'help', 'alpha', 'dashboard', 'neo-tree', 'Trouble', 'lazy', 'mason' },
        fold_virt_text_handler = handler,
        provider_selector = function(bufnr, filetype, buftype)
            return { 'lsp', 'indent' }
        end
    },
    config = function(_, opts)
        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('local_detach_ufo', { clear = true }),
            pattern = opts.filetype_exclude,
            callback = function()
                require('ufo').detach()
            end,
        })
        local keybinding = require("keybindings")
        keybinding.register_keymap('n', "zR", { require("ufo").openAllFolds, desc = "Open all folds" })
        keybinding.register_keymap('n', "zM", { require('ufo').closeAllFolds, desc = "Close all folds" })
        keybinding.register_keymap('n', "zr", { require('ufo').openFoldsExceptKinds, desc = "Open fold except" })
        keybinding.register_keymap('n', "zm", { require('ufo').closeFoldsWith, desc = "Close folds with" }) -- closeAllFolds == closeFoldsWith(0)
        keybinding.register_keymap('n', "zp", {
            function()
                local winid = require('ufo').peekFoldedLinesUnderCursor()
                if not winid then
                    vim.lsp.buf.hover()
                end
            end,
            desc = "Peek fold"
        })
        require('ufo').setup(opts)
    end,
}
