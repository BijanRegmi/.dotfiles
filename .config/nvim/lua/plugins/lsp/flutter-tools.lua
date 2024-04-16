return {
    "akinsho/flutter-tools.nvim",
    ft = "dart",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        lsp = {
            on_attach = require("plugins.lsp.keymaps").on_attach,
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
            },
        },
    }
}
