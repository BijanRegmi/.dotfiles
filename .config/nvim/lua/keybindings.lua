local M = {}

vim.g.mapleader = " "
vim.g.maplocalleader = " "

function M.extend_tbl(default, opts)
    opts = opts or {}
    return default and vim.tbl_deep_extend("force", default, opts) or opts
end

M.which_key_queue = {}

function M.which_key_register()
    if M.which_key_queue then
        local wk_avail, wk = pcall(require, "which-key")
        if wk_avail then
            for mode, registration in pairs(M.which_key_queue) do
                wk.register(registration, { mode = mode })
            end
            M.which_key_queue = nil
        end
    end
end

function M.register_keymap(mode, keymap, options)
    if options == nil then
        return
    end

    local cmd = options
    local keymap_opts = { noremap = true, silent = false }
    if type(options) == "table" then
        cmd = options[1]
        keymap_opts = vim.tbl_deep_extend("force", keymap_opts, options)
        keymap_opts[1] = nil
    end
    if not cmd or keymap_opts.name then -- if which-key mapping, queue it
        if not keymap_opts.name then keymap_opts.name = keymap_opts.desc end
        if not M.which_key_queue then M.which_key_queue = {} end
        if not M.which_key_queue[mode] then M.which_key_queue[mode] = {} end
        local to_queue = true
        if package.loaded["which-key"] then
            local wk_avail, wk = pcall(require, "which-key")
            if wk_avail then
                to_queue = false
                local wk_option = {}
                wk_option[keymap] = keymap_opts
                wk.register(wk_option, { mode = mode })
            end
        end
        if to_queue then
            M.which_key_queue[mode][keymap] = keymap_opts
        end
    else -- if not which-key mapping, set it
        vim.keymap.set(mode, keymap, cmd, keymap_opts)
    end
end

function M.setup()
    -- Assing space as leader key
    M.register_keymap("", "<Space>", "<Nop>")

    -- Input Manipulation
    M.register_keymap('n', "<A-j>", { ":m .+1<CR>==", desc = "Move line down" })
    M.register_keymap('n', "<A-k>", { ":m .-2<CR>==", desc = "Move line up" })
    M.register_keymap('v', "<A-j>", { ":m '>+1<CR>gv=gv", desc = "Move blocks of line down" })
    M.register_keymap('v', "<A-k>", { ":m '<-2<CR>gv=gv", desc = "Move blocks of line up" })
    M.register_keymap('n', 'xx', { '"_dd', desc = "Delete without copying to  register" })
    M.register_keymap('v', 'x', '"_d')

    -- Buffer
    M.register_keymap('n', "<C-n>", { ":BufferLineCycleNext<CR>", desc = "Go to next buffer" })
    M.register_keymap('n', "<C-p>", { ":BufferLineCyclePrev<CR>", desc = "Go to previous buffer" })
    M.register_keymap('n', "<leader>n", { ":BufferLineMoveNext<CR>", desc = "Move current buffer to right" })
    M.register_keymap('n', "<leader>p", { ":BufferLineMovePrev<CR>", desc = "Move current buffer to left" })
    M.register_keymap('n', "<leader>w", { ":bd<CR>", desc = "Close current buffer" })
    M.register_keymap('n', "<leader>g", { ":BufferLinePick<CR>", desc = "Pick a buffer to go to" })
    M.register_keymap('n', "<leader>o", { ":only<CR>", desc = "Show only current buffer" })
    M.register_keymap('n', "<leader>1", { "<Cmd>BufferLineGoToBuffer 1<CR>", desc = "Go to buffer 1" })
    M.register_keymap('n', "<leader>2", { "<Cmd>BufferLineGoToBuffer 2<CR>", desc = "Go to buffer 2" })
    M.register_keymap('n', "<leader>3", { "<Cmd>BufferLineGoToBuffer 3<CR>", desc = "Go to buffer 3" })
    M.register_keymap('n', "<leader>4", { "<Cmd>BufferLineGoToBuffer 4<CR>", desc = "Go to buffer 4" })
    M.register_keymap('n', "<leader>5", { "<Cmd>BufferLineGoToBuffer 5<CR>", desc = "Go to buffer 5" })
    M.register_keymap('n', "<leader>6", { "<Cmd>BufferLineGoToBuffer 6<CR>", desc = "Go to buffer 6" })
    M.register_keymap('n', "<leader>7", { "<Cmd>BufferLineGoToBuffer 7<CR>", desc = "Go to buffer 7" })
    M.register_keymap('n', "<leader>8", { "<Cmd>BufferLineGoToBuffer 8<CR>", desc = "Go to buffer 8" })
    M.register_keymap('n', "<leader>9", { "<Cmd>BufferLineGoToBuffer 9<CR>", desc = "Go to buffer 9" })

    -- Window
    M.register_keymap('n', "<leader>\\", { ":vsp<CR>", desc = "Open vertical split" })
    M.register_keymap('n', "<leader>-", { ":sp<CR>", desc = "Open horizontal split" })
    M.register_keymap('n', "<leader>j", { "<C-W><C-J>", desc = "Move to left split window" })
    M.register_keymap('n', "<leader>k", { "<C-W><C-K>", desc = "Move to below split window" })
    M.register_keymap('n', "<leader>l", { "<C-W><C-L>", desc = "Move to right split window" })
    M.register_keymap('n', "<leader>h", { "<C-W><C-H>", desc = "Move to above split window" })
    M.register_keymap('n', "re", { ":resize<CR>", desc = "Expand current window vertically" })
    M.register_keymap('n', "rs", { ":resize 0<CR>", desc = "Collapse current window vertically" })
    M.register_keymap('n', "r=", { ":horizontal wincmd =<CR>", desc = "Even window width" })
    M.register_keymap('n', "ce", { ":vertical resize<CR>", desc = "Expand current window horizontally" })
    M.register_keymap('n', "cs", { ":vertical resize 0<CR>", desc = "Collapse current window horizontally" })
    M.register_keymap('n', "c=", { ":vertical wincmd =<CR>", desc = "Even window height" })
    M.register_keymap('n', "<C-Up>", { ":resize +2<CR>", desc = "Expand row size" })
    M.register_keymap('n', "<C-Down>", { ":resize -2<CR>", desc = "Reduce row size" })
    M.register_keymap('n', "<C-Left>", { ":vertical resize -2<CR>", desc = "Expand column size" })
    M.register_keymap('n', "<C-Right>", { ":vertical resize +2<CR>", desc = "Reduct column size" })

    -- Explorer
    M.register_keymap('n', "<C-e>", { ":NvimTreeToggle<CR>", desc = "Toggle nvim tree" })
    M.register_keymap('n', "<C-f>", { ":Telescope find_files<CR>", desc = "Telescope find files" })
    M.register_keymap('n', "<C-g>", { ":Telescope live_grep<CR>", desc = "Telescope live grep" })

    -- Git
    M.register_keymap('n', "gbl", { ":Gitsigns blame_line<CR>", desc = "Git blame line" })
    M.register_keymap('n', "ghp", { ":Gitsigns preview_hunk<CR>", desc = "Git preview hunk" })
    M.register_keymap('n', "gnh", { ":Gitsigns next_hunk<CR>", desc = "Git next hunk" })
    M.register_keymap('n', "gph", { ":Gitsigns prev_hunk<CR>", desc = "Git previous hunk" })
    M.register_keymap('n', "gdt", { ":Gitsigns diffthis<CR>", desc = "Git diff this" })
    M.register_keymap('n', "gsh", { ":Gitsigns stage_hunk<CR>", desc = "Git stage hunk" })
    M.register_keymap('n', "grh", { ":Gitsigns reset_hunk<CR>", desc = "Git reset hunk" })
    M.register_keymap('n', "grb", { ":Gitsigns reset_buffer<CR>", desc = "Git reset buffer" })
    M.register_keymap('n', "guh", { ":Gitsigns undo_stage_hunk<CR>", desc = "Git undow stage hunk" })
    M.register_keymap('n', "gsb", { ":Gitsigns stage_buffer<CR>", desc = "Git stage buffer" })

    -- Formatter
    M.register_keymap('n', '<leader>f', {
        function()
            vim.lsp.lua.format({ async = true })
        end,
        desc = "Format buffer"
    }
    )
    M.register_keymap('v', "<leader>f", { "<Cmd>lua vim.lsp.buf.range_formatting()<CR>", desc = "Format selected" })

    -- Competitest
    M.register_keymap('n', "<leader>cmr", { "<Cmd>CompetiTestRun<CR>", desc = "Run Test" })
    M.register_keymap('n', "<leader>cmp", { "<Cmd>CompetiTestReceive problem<CR>", desc = "Receive Test" })

    -- Diagnostics
    M.register_keymap('n', '<space>d', { vim.diagnostic.open_float, desc = "View diagnostic" })
    M.register_keymap('n', '[d', { vim.diagnostic.goto_prev, desc = "Go to next diagnostic" })
    M.register_keymap('n', ']d', { vim.diagnostic.goto_next, desc = "Go to previous diagnostic" })
end

return M
