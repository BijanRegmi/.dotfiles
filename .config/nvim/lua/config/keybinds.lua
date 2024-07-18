vim.g.leader = " "
vim.g.mapleader = " "

vim.keymap.set("", "<Space>", "<Nop>")

local utils = require("config.utils")
local keyopts = utils.keymap.opts

-- Input Manipulation
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", keyopts("Move line down"))
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", keyopts("Move line up"))
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", keyopts("Move blocks of line down"))
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", keyopts("Move blocks of line up"))
vim.keymap.set("x", "<leader>d", '"_d', keyopts("Delete without yank"))
vim.keymap.set("x", "<leader>p", '"_dP', keyopts("Paste without yank"))

-- Buffer
vim.keymap.set("n", "<C-n>", ":BufferLineCycleNext<CR>", keyopts("Go to next buffer"))
vim.keymap.set("n", "<C-p>", ":BufferLineCyclePrev<CR>", keyopts("Go to previous buffer"))
vim.keymap.set("n", "<leader>n", ":BufferLineMoveNext<CR>", keyopts("Move current buffer to right"))
vim.keymap.set("n", "<leader>p", ":BufferLineMovePrev<CR>", keyopts("Move current buffer to left"))
vim.keymap.set("n", "<leader>w", ":bd<CR>", keyopts("Close current buffer"))
vim.keymap.set("n", "<leader>g", ":BufferLinePick<CR>", keyopts("Pick a buffer to go to"))
vim.keymap.set("n", "<leader>o", ":only<CR>", keyopts("Show only current buffer"))

-- Window
vim.keymap.set("n", "<leader>\\", ":vsp<CR>", keyopts("Vertical split"))
vim.keymap.set("n", "<leader>-", ":sp<CR>", keyopts("Horizontal split"))
vim.keymap.set("n", "<leader>j", "<C-W><C-J>", keyopts("Move to left split window"))
vim.keymap.set("n", "<leader>k", "<C-W><C-K>", keyopts("Move to below split window"))
vim.keymap.set("n", "<leader>l", "<C-W><C-L>", keyopts("Move to right split window"))
vim.keymap.set("n", "<leader>h", "<C-W><C-H>", keyopts("Move to above split window"))
vim.keymap.set("n", "re", ":resize<CR>", keyopts("Expand current window vertically"))
vim.keymap.set("n", "rs", ":resize 0<CR>", keyopts("Collapse current window vertically"))
vim.keymap.set("n", "r=", ":horizontal wincmd =<CR>", keyopts("Even window width"))
vim.keymap.set("n", "ce", ":vertical resize<CR>", keyopts("Expand current window horizontally"))
vim.keymap.set("n", "cs", ":vertical resize 0<CR>", keyopts("Collapse current window horizontally"))
vim.keymap.set("n", "c=", ":vertical wincmd =<CR>", keyopts("Even window height"))
vim.keymap.set("n", "<C-k>", ":resize +2<CR>", keyopts("Expand row size"))
vim.keymap.set("n", "<C-j>", ":resize -2<CR>", keyopts("Reduce row size"))
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", keyopts("Expand column size"))
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", keyopts("Reduct column size"))

-- Colorscheme
vim.keymap.set("n", "<leader>c", utils.colorscheme.select, keyopts("Change colorscheme"))

vim.keymap.set("n", "<leader>i", function()
    if vim.bo.ft == "typescript" then
        vim.lsp.buf.code_action({
            apply = true,
            context = {
                only = { "source.addMissingImports" },
                diagnostics = {},
            },
        })
        vim.lsp.buf.code_action({
            apply = true,
            context = {
                only = { "source.organizeImports" },
                diagnostics = {},
            },
        })
    end
end, keyopts("Organize imports"))
