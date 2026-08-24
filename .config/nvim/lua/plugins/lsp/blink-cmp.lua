return {
  {
    "saghen/blink.cmp",
    event = "BufRead",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    version = "1.*",
    opts = {
      enabled = function ()
        return not vim.list_contains({ "DressingInput" }, vim.bo.filetype)
          and vim.bo.buftype ~= "prompt"
          and vim.b.completion ~= false
      end,
      keymap = {
        ["<A-j>"] = { "select_next", "fallback" },
        ["<A-k>"] = { "select_prev", "fallback" },
        ["<A-i>"] = { "show", "fallback" },
        ["<A-l>"] = { "cancel", "fallback" },
        ["<C-j>"] = {
          function (cmp)
            cmp.scroll_documentation_up(4)
          end,
          "fallback",
        },
        ["<C-k>"] = {
          function (cmp)
            cmp.scroll_documentation_down(4)
          end,
          "fallback",
        },
        ["<CR>"] = { "accept", "fallback" },
      },
      appearance = {
        nerd_font_variant = "mono",
        kind_icons = require("config.utils").icons.lspkind,
      },
      -- (Default) Only show the documentation popup when manually triggered
      completion = {
        menu = {
          auto_show = true,
          border = "rounded",
          draw = {
            columns = {
              { "kind_icon" },
              { "label" },
              { "source_name", "kind", gap = 1 },
            },
            components = {
              source_name = {
                width = { max = 2 },
                text = function (ctx)
                  if ctx.source_name == "LSP" then
                    return "󰒓"
                  elseif ctx.source_name == "Snippets" then
                    return ""
                  elseif ctx.source_name == "Buffer" then
                    return ""
                  elseif ctx.source_name == "Path" then
                    return ""
                  else
                    return " "
                  end
                end,
                highlight = "BlinkCmpSource",
              },
            },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 100,
          window = { border = "rounded" },
        },
        ghost_text = {
          enabled = false,
        },
      },
      sources = {
        default = {
          "lsp",
          "path",
          "snippets",
          "buffer",
        },
      },
      fuzzy = {
        implementation = "prefer_rust_with_warning",
      },
    },
    opts_extend = { "sources.default" },
  },
}
