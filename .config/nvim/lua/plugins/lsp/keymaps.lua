local keyopts = require("config.utils").keymap.opts

return {
    on_attach = function(_, bufnr)
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, keyopts("Go to declaration", bufnr))
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, keyopts("Go to definition", bufnr))
        vim.keymap.set("n", "K", vim.lsp.buf.hover, keyopts("View docs", bufnr))
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, keyopts("Go to implementation", bufnr))
        vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, keyopts("Signature help", bufnr))
        vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, keyopts("Go to type definition", bufnr))
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, keyopts("Rename symbol", bufnr))
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, keyopts("View code action", bufnr))
        vim.keymap.set("n", "gr", vim.lsp.buf.references, keyopts("Go to references", bufnr))
    end,
}
