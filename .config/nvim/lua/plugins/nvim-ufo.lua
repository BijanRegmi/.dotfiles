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
            return { 'lsp', 'treesitter' }
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
        vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
        vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
        vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
        vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
        vim.keymap.set('n', 'zp', function()
            local winid = require('ufo').peekFoldedLinesUnderCursor()
            if not winid then
                vim.lsp.buf.hover()
            end
        end)
        require('ufo').setup(opts)
    end,
}
--[[ require('ufo').setup({ ]]
--[[     open_fold_hl_timeout = 150, ]]
--[[     close_fold_kinds = { 'imports', 'comment' }, ]]
--[[     preview = { ]]
--[[         win_config = { ]]
--[[             border = { '', '─', '', '', '', '─', '', '' }, ]]
--[[             winhighlight = 'Normal:Folded', ]]
--[[             winblend = 0 ]]
--[[         }, ]]
--[[         mappings = { ]]
--[[             scrollU = '<C-u>', ]]
--[[             scrollD = '<C-d>', ]]
--[[             jumpTop = '[', ]]
--[[             jumpBot = ']' ]]
--[[         } ]]
--[[     }, ]]
--[[ }) ]]
