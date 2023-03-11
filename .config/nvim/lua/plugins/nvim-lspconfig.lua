return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "mason.nvim",
        {
            "williamboman/mason-lspconfig.nvim",
            opts = { automatic_installation = true }
        }, 'cmp-nvim-lsp'
    },
    config = function(_, opts)
        local lsp_config = require("lspconfig")

        local servers = {
            'bashls', 'clangd', 'cmake', 'cssls', 'eslint', 'html', 'jsonls',
            'marksman', 'pylsp', 'tsserver', 'prismals', 'tailwindcss', 'lua_ls'
        }

        local on_attach = function(client, bufnr)
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
        end

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities =
            require('cmp_nvim_lsp').default_capabilities(capabilities)

        for _, server in pairs(servers) do
            local opts = { on_attach = on_attach, capabilities = capabilities }

            -- Load additional settings if its available
            local available, options = pcall(require,
                "immo.lsp.options." .. server)
            if available then
                opts = vim.tbl_deep_extend("force", opts, options)
            end

            lsp_config[server].setup(opts)
        end
    end
}
