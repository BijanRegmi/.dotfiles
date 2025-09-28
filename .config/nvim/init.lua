require("config.settings")
require("config.keybinds")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", { change_detection = { notify = false }, ui = { border = "rounded" } })

vim.cmd.colorscheme(require("config.utils").colorscheme.default)

local autocmd = vim.api.nvim_create_autocmd
autocmd("TextYankPost", {
  pattern = "*",
  callback = function ()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 80,
    })
  end,
})
