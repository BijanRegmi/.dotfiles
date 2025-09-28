local keyopts = require("config.utils").keymap.opts

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "williamboman/mason.nvim",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
  },
  event = "VeryLazy",
  init = function ()
    local icons = require("config.utils").icons
    for name, sign in pairs(icons.dap) do
      sign = type(sign) == "table" and sign or { sign }
      vim.fn.sign_define(
        "Dap" .. name,
        { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
      )
    end
  end,
  config = function ()
    local dap = require("dap")

    require("plugins.dap.config.typescript")

    -- keymaps
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, keyopts("Toggle Breakpoint"))
    vim.keymap.set("n", "<leader>dc", dap.continue, keyopts("Run/Continue"))
    vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, keyopts("Run to Cursor"))
    vim.keymap.set("n", "<leader>dg", dap.run_to_cursor, keyopts("Go to Line (No Execute)"))
    vim.keymap.set("n", "<leader>di", dap.step_into, keyopts("Step Into"))
    vim.keymap.set("n", "<leader>dj", dap.down, keyopts("Down"))
    vim.keymap.set("n", "<leader>dk", dap.up, keyopts("Up"))
    vim.keymap.set("n", "<leader>dl", dap.run_last, keyopts("Run Last"))
    vim.keymap.set("n", "<leader>do", dap.step_out, keyopts("Step Out"))
    vim.keymap.set("n", "<leader>dO", dap.step_over, keyopts("Step Over"))
    vim.keymap.set("n", "<leader>dP", dap.pause, keyopts("Pause"))
    vim.keymap.set("n", "<leader>dr", dap.repl.toggle, keyopts("Toggle REPL"))
    vim.keymap.set("n", "<leader>ds", dap.session, keyopts("Session"))
    vim.keymap.set("n", "<leader>dt", dap.terminate, keyopts("Terminate"))
    vim.keymap.set("n", "<leader>dw", require("dap.ui.widgets").hover, keyopts("Widgets"))

    local vscode = require("dap.ext.vscode")
    local json = require("plenary.json")
    vscode.json_decode = function (str)
      return vim.json.decode(json.json_strip_comments(str))
    end
  end,
}
