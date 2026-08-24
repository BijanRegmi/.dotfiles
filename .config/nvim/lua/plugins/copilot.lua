return {
  "github/copilot.vim",
  event = "InsertEnter",
  config = function ()
    local opts = { expr = true, silent = true }

    vim.g.copilot_no_tab_map = true
    vim.keymap.set("i", "<A-l>", 'copilot#Accept("\\<CR>")', opts)
  end,
}
