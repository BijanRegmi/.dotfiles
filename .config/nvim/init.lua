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

local function extract_decorators ()
  -- 1. Get all lines from the current buffer
  -- (0 refers to the current buffer, 0 to -1 means first line to last line)
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  local methods = { "Get", "Post", "Patch", "Delete" }
  local results = {}

  -- 2. Process the lines (Equivalent to your .map and .filter)
  for _, line in ipairs(lines) do
    local trimmed = vim.trim(line)
    for _, method in ipairs(methods) do
      if vim.startswith(trimmed, "@" .. method) then
        table.insert(results, trimmed)
        break
      end
    end
  end

  -- 3. Create a new scratch buffer for the output
  local out_buf = vim.api.nvim_create_buf(false, true) -- listed=false, scratch=true
  vim.api.nvim_buf_set_lines(out_buf, 0, -1, false, results)

  -- 4. Open the new buffer in a vertical split
  vim.api.nvim_command("vsplit")
  vim.api.nvim_win_set_buf(0, out_buf)
end

-- Create a user command so you can run it via :ExtractMethods
vim.api.nvim_create_user_command("ExtractMethods", extract_decorators, {})
