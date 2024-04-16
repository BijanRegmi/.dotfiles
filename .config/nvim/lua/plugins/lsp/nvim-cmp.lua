return {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "onsails/lspkind-nvim",
        "L3MON4D3/LuaSnip",
    },
    config = function(_, opts)
        local cmp = require("cmp")
        local lspkind = require("lspkind")
        local luasnip = require("luasnip")
        local lspkind_fmt = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            preset = "codicons",
        })
        local icons = require("config.utils").icons.lspkind

        cmp.setup({
            completion = {
                completeopt = "menu,menuone,preview,noselect",
            },
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    local kind = lspkind_fmt(entry, vim_item)
                    local strings = vim.split(kind.kind, "%s", { trimempty = true })

                    kind.kind = strings[1] or " "
                    kind.menu = (icons[strings[2]] or "") .. " " .. (strings[2] or "")
                    return kind
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<A-j>"] = cmp.mapping.select_next_item(),
                ["<A-k>"] = cmp.mapping.select_prev_item(),
                ["<A-i>"] = cmp.mapping.complete(),
                ["<A-l>"] = cmp.mapping.abort(),
                ["<C-j>"] = cmp.mapping.scroll_docs(4),
                ["<C-k>"] = cmp.mapping.scroll_docs(-4),
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
            }),
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            sources = {
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" },
            },
            window = {
                completion = cmp.config.window.bordered({
                    border = "rounded",
                }),
                documentation = cmp.config.window.bordered({
                    border = "rounded",
                }),
            },
        })
    end,
}
