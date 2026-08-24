local keyopts = require("config.utils").keymap.opts

---@param client vim.lsp.Client
---@param bufnr integer
local function on_attach (client, bufnr)
  -- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  vim.keymap.set("n", "sgd", ":vsplit | lua vim.lsp.buf.definition()<CR>", keyopts("[S]plit and [G]oto [D]efinition", bufnr))
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, keyopts("[G]oto [D]efinition", bufnr))
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, keyopts("[G]oto [D]eclaration", bufnr))
  vim.keymap.set("n", "gr", vim.lsp.buf.references, keyopts("[G]oto [R]eferences", bufnr))
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, keyopts("[G]oto [I]mplementation", bufnr))
  vim.keymap.set("n", "K", function ()
    vim.lsp.buf.hover({ border = "rounded" })
  end, keyopts("View docs", bufnr))
  vim.keymap.set("i", "<C-k>", function ()
    vim.lsp.buf.signature_help({ border = "rounded" })
  end, keyopts("Signature help", bufnr))
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
  "neovim/nvim-lspconfig",
  event = "BufRead",
  dependencies = {
    "mason.nvim",
    { "mason-org/mason-lspconfig.nvim", opts = {} },
  },
  init = function ()
    vim.o.completeopt = "menuone,noselect"
  end,
  config = function ()
    local icons = require("config.utils").icons.diagnostics
    vim.diagnostic.config({
      severity_sort = true,
      float = { border = "rounded", source = "if_many" },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = icons.error,
          [vim.diagnostic.severity.WARN] = icons.warn,
          [vim.diagnostic.severity.HINT] = icons.hint,
          [vim.diagnostic.severity.INFO] = icons.info,
        },
      },
      virtual_text = {
        source = "if_many",
        spacing = 2,
        format = function (diagnostic)
          local diagnostic_message = {
            [vim.diagnostic.severity.ERROR] = diagnostic.message,
            [vim.diagnostic.severity.WARN] = diagnostic.message,
            [vim.diagnostic.severity.INFO] = diagnostic.message,
            [vim.diagnostic.severity.HINT] = diagnostic.message,
          }
          return diagnostic_message[diagnostic.severity]
        end,
      },
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()

    require("lspconfig.ui.windows").default_options.border = "rounded"

    ---@type string[]
    local servers = require("mason-lspconfig").get_installed_servers()

    for _, server in ipairs(servers) do
      local opts = { on_attach = on_attach, capabilities = capabilities }

      local available, server_options = pcall(require, "plugins.lsp.configs." .. server)
      if available then
        opts = vim.tbl_deep_extend("force", opts, server_options)
      end

      vim.lsp.config[server] = opts
    end

    -- Prefer the project-pinned FVM SDK, fall back to the global dart on PATH.
    local fvm_dart = vim.fn.getcwd() .. "/.fvm/flutter_sdk/bin/dart"
    local dart_bin = vim.fn.executable(fvm_dart) == 1 and fvm_dart or "dart"

    vim.lsp.config.dartls = {
      cmd = { dart_bin, "language-server", "--protocol=lsp", "--client-id=neovim" },
      filetypes = { "dart" },
      root_markers = { "pubspec.yaml", "pubspec.yml", "pubspec.lock" },
      on_attach = on_attach,
      capabilities = capabilities,
      init_options = {
        onlyAnalyzeProjectsWithOpenFiles = false,
        suggestFromUnimportedLibraries = true,
        closingLabels = true,
        outline = true,
        flutterOutline = true,
      },
      settings = {
        dart = {
          completeFunctionCalls = true,
          showTodos = true,
        },
      },
    }
    vim.lsp.enable("dartls")
  end,
}
