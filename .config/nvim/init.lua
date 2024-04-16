require("config.settings")
require("config.keybinds")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", { change_detection = { notify = false }, ui = { border = "rounded" } })

vim.cmd.colorscheme(require("config.utils").colorscheme.default)

local autocmd = vim.api.nvim_create_autocmd
autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 80,
        })
    end,
})
