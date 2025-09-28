return {
  "stevearc/conform.nvim",
  event = "BufRead",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black" },
      rust = { "rustfmt" },
      javascript = { "prettier" },
      typescript = { "prettier" },
    },
  },
}
