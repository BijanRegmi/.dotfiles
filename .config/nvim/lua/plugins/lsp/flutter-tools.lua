local keyopts = require("config.utils").keymap.opts

---@param client vim.lsp.Client
---@param bufnr integer
local function on_attach (client, bufnr)
  -- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, keyopts("[G]oto [D]efinition", bufnr))
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, keyopts("[G]oto [D]eclaration", bufnr))
  vim.keymap.set("n", "gr", vim.lsp.buf.references, keyopts("[G]oto [R]eferences", bufnr))
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, keyopts("[G]oto [I]mplementation", bufnr))
  vim.keymap.set("n", "K", vim.lsp.buf.hover, keyopts("View docs", bufnr))
  vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, keyopts("Signature help", bufnr))
  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, keyopts("Goto type [D]efinition", bufnr))
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, keyopts("[R]e[n]ame symbol", bufnr))
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, keyopts("[C]ode [A]ction", bufnr))

  if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
    vim.keymap.set("n", "<C-k>", function ()
      vim.lsp.buf.clear_references()
      vim.lsp.buf.document_highlight()
    end, keyopts("Document highlight", bufnr))
  end

  if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
    vim.keymap.set("n", "<C-i>", function ()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
    end, keyopts("Toggle inlay hints", bufnr))
  end
end

return {
  "akinsho/flutter-tools.nvim",
  ft = "dart",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    lsp = {
      on_attach = on_attach,
      settings = {
        showTodos = true,
        completeFunctionCalls = true,
        renameFilesWithClasses = "prompt",
        enableSnippets = true,
        updateImportsOnRename = true,
      },
    },
  },
}
