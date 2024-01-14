local keyopts = require("config.utils").keymap.opts

return {
    "neovim/nvim-lspconfig",
    event = "BufRead",
    dependencies = {
        "mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "nvim-cmp",
    },
    init = function()
        vim.o.completeopt = "menuone,noselect"

        local icons = require("config.utils").icons.diagnostics
        local signs = {
            { name = "DiagnosticSignError", text = icons.error },
            { name = "DiagnosticSignWarn",  text = icons.warn },
            { name = "DiagnosticSignHint",  text = icons.hint },
            { name = "DiagnosticSignInfo",  text = icons.info },
        }

        for _, sign in ipairs(signs) do
            vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
        end

        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, keyopts("View diagnostic"))
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, keyopts("Go to next diagnostic"))
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, keyopts("Go to previous diagnostic"))
        vim.keymap.set("n", "<leader>f", "<Cmd>lua vim.lsp.buf.format({async = true})<CR>", keyopts("Format document"))
        vim.keymap.set("v", "<leader>f", "<Cmd>lua vim.lsp.buf.range_formatting()<CR>", keyopts("Format selected"))
    end,
    config = function()
        local lsp_config = require("lspconfig")
        require("lspconfig.ui.windows").default_options.border = "rounded"
        local servers = require("mason-lspconfig").get_installed_servers()

        local on_attach = require("plugins.lsp.keymaps").on_attach
        local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
        local handlers = {
            ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
            ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
        }

        for _, server in ipairs(servers) do
            local opts = { on_attach = on_attach, capabilities = capabilities, handlers = handlers }

            local available, server_options = pcall(require, "config.lsp." .. server)
            if available then
                opts = vim.tbl_deep_extend("force", opts, server_options)
            end

            lsp_config[server].setup(opts)
        end
    end,
}
