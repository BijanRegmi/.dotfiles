local options = { noremap = true, silent=false}
local keymap = vim.api.nvim_set_keymap

-- Assing space as leader key
keymap("", "<Space>", "<Nop>", options)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Input Manipulation
keymap('n', "<A-j>", ":m .+1<CR>==", options)                           -- Move line down
keymap('n', "<A-k>", ":m .-2<CR>==", options)                           -- Move line up
keymap('i', "<A-j>", "<Esc>:m .+1<CR>==gi", options)                    -- Move line down
keymap('i', "<A-k>", "<Esc>:m .-2<CR>==gi", options)                    -- Move line up
keymap('v', "<A-j>", ":m '>+1<CR>gv=gv", options)                       -- Move block of lines down
keymap('v', "<A-k>", ":m '<-2<CR>gv=gv", options)                       -- Move block of lines up

-- Window   
keymap('n', "<leader>\\", ":vsp<CR>", options)                          -- Open vertical split
keymap('n', "<leader>-", ":sp<CR>", options)                            -- Open horizontal split
keymap('n', "<leader>j", "<C-W><C-J>", options)                         -- Move to left  split window
keymap('n', "<leader>k", "<C-W><C-K>", options)                         -- Move to below split window
keymap('n', "<leader>l", "<C-W><C-L>", options)                         -- Move to right split window
keymap('n', "<leader>h", "<C-W><C-H>", options)                         -- Move to above split window
keymap('n', "re", ":resize<CR>", options)                               -- Max number of rows
keymap('n', "rs", ":resize 0<CR>", options)                             -- 0 rows
keymap('n', "ce", ":vertical resize<CR>", options)                      -- Max number of columns
keymap('n', "cs", ":vertical resize 0<CR>", options)                    -- 0 columns
keymap("n", "<C-Up>", ":resize +2<CR>", options)                        -- Expand row size
keymap("n", "<C-Down>", ":resize -2<CR>", options)                      -- Reduce row size
keymap("n", "<C-Left>", ":vertical resize -2<CR>", options)             -- Expand column size
keymap("n", "<C-Right>", ":vertical resize +2<CR>", options)            -- Reduce column size