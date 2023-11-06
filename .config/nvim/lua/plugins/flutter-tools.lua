return {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = function()
        require("flutter-tools").setup({
            lsp = {
                on_attach = function(client, bufnr)
                    vim.api.nvim_buf_set_option(bufnr, 'omnifunc',
                        'v:lua.vim.lsp.omnifunc')

                    local register_keymap = require("keybindings").register_keymap
                    register_keymap('n', 'gD', { vim.lsp.buf.declaration, buffer = bufnr, desc = "Go to declaration" })
                    register_keymap('n', 'gd', { vim.lsp.buf.definition, buffer = bufnr, desc = "Go to definition", })
                    register_keymap('n', 'K', { vim.lsp.buf.hover, buffer = bufnr, desc = "View docs" })
                    register_keymap('n', 'gi',
                        { vim.lsp.buf.implementation, buffer = bufnr, desc = "Go to implementation" })
                    register_keymap('n', '<C-k>', { vim.lsp.buf.signature_help, buffer = bufnr, desc = "Signature help" })
                    register_keymap('n', '<space>D',
                        { vim.lsp.buf.type_definition, buffer = bufnr, desc = "Go to type definition" })
                    register_keymap('n', '<space>rn', { vim.lsp.buf.rename, buffer = bufnr, desc = "Rename symbol" })
                    register_keymap('n', '<space>ca',
                        { vim.lsp.buf.code_action, buffer = bufnr, desc = "View code action" })
                    register_keymap('n', 'gr', { vim.lsp.buf.references, buffer = bufnr, desc = "Go to references" })
                    register_keymap('n', '<space>f', { vim.lsp.buf.format, buffer = bufnr, desc = "Format document" })
                end,
                capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
                handlers = {
                    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
                    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" }),
                },
                settings = {
                    showTodos = true,
                    completeFunctionCalls = true,
                    renameFilesWithClasses = "prompt",
                    enableSnippets = true,
                    updateImportsOnRename = true,
                }
            }
        })
    end
}
