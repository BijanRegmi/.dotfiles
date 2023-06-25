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

                    local bufopts = { noremap = true, silent = true, buffer = bufnr }
                    local setKeymap = vim.keymap.set

                    setKeymap('n', 'gD', vim.lsp.buf.declaration, bufopts)
                    setKeymap('n', 'gd', vim.lsp.buf.definition, bufopts)
                    setKeymap('n', 'K', vim.lsp.buf.hover, bufopts)
                    setKeymap('n', 'gi', vim.lsp.buf.implementation, bufopts)
                    setKeymap('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
                    setKeymap('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
                    setKeymap('n', '<space>rn', vim.lsp.buf.rename, bufopts)
                    setKeymap('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
                    setKeymap('n', 'gr', vim.lsp.buf.references, bufopts)
                    setKeymap('n', '<space>f', vim.lsp.buf.format, bufopts)
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
