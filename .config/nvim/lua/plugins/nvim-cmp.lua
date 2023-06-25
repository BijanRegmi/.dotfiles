return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp", "onsails/lspkind-nvim", {
        "L3MON4D3/LuaSnip",
        config = function(_, opts)
            local luasnip = require('luasnip')
            luasnip.config.setup({ store_selection_keys = "<A-p>" })

            -- load snipets
            require("luasnip.loaders.from_lua").load({
                paths = "~/.config/nvim/snippets/"
            })
            vim.cmd(
                [[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]])

            local types = require("luasnip.util.types")
            luasnip.config.set_config({
                history = true,
                updateevents = "TextChanged,TextChangedI",
                enable_autosnippets = true,
                ext_opts = {
                    [types.choiceNode] = {
                        active = { virt_text = { { "●", "GruvboxOrange" } } }
                    }
                }
            })
        end
    }, "rafamadriz/friendly-snippets"
    },
    config = function(_, opts)
        local cmp = require('cmp')
        local luasnip = require('luasnip')
        local lspkind = require('lspkind')

        vim.o.completeopt = 'menuone,noselect'

        local signs = {
            { name = "DiagnosticSignError", text = "" },
            { name = "DiagnosticSignWarn",  text = "" },
            { name = "DiagnosticSignHint",  text = "" },
            { name = "DiagnosticSignInfo",  text = "" },
        }

        for _, sign in ipairs(signs) do
            vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
        end

        local icons = {
            Text = "",
            Method = "󰆧",
            Function = "󰊕",
            Constructor = "",
            Field = "󰇽",
            Variable = "󰂡",
            Class = "󰠱",
            Interface = "",
            Module = "",
            Property = "󰜢",
            Unit = "",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󰏘",
            File = "󰈙",
            Reference = "",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰏿",
            Struct = "",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "󰅲",
        }

        local check_backspace = function()
            local col = vim.fn.col "." - 1
            return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
        end
        cmp.setup {
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    local kind = lspkind.cmp_format({
                        mode = "symbol_text",
                        maxwidth = 50,
                        preset = "codicons"
                    })(entry, vim_item)
                    local strings = vim.split(kind.kind, "%s",
                        { trimempty = true })

                    kind.kind = strings[1] or " "
                    kind.menu = (icons[strings[2]] or "") .. " " .. (strings[2] or "")
                    return kind
                end
            },
            mapping = {
                ["<A-j>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expandable() then
                        luasnip.expand()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif check_backspace() then
                        fallback()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<A-k>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ['<CR>'] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true
                },
                ["<A-l>"] = cmp.mapping {
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close()
                },
                ["<A-i>"] = cmp.mapping {
                    i = cmp.mapping.complete()
                },
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },
            sources = { { name = 'nvim_lsp' }, { name = 'luasnip' } },
            window = {
                completion = cmp.config.window.bordered({
                    border = "rounded",
                }),
                documentation = cmp.config.window.bordered({
                    border = "rounded"
                }),
            },
        }
    end
}
