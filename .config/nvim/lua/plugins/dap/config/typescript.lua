local dap = require("dap")
local mason_registry = require("mason-registry")

local js_debug_path = vim.fn.exepath("js-debug-adapter")
local dap_executable = js_debug_path .. "/js-debug/src/dapDebugServer.js"

for _, type in ipairs({
  "chrome",
  "pwa-node",
  "pwa-chrome",
  "pwa-msedge",
  "node-terminal",
  "pwa-extensionHost",
}) do
  dap.adapters[type] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
      command = "node",
      args = { dap_executable, "${port}", host },
    },
  }
end

for _, language in ipairs({ "typescript", "javascript" }) do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file (with node)",
      cwd = vim.fn.getcwd(),
      program = "${file}",
      sourceMaps = true,
      protocol = "inspector",
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file (with ts-node)",
      cwd = vim.fn.getcwd(),
      runtimeExecutable = "node",
      runtimeArgs = { "--loader", "ts-node/esm" },
      args = { "${file}" },
      sourceMaps = true,
      protocol = "inspector",
      skipFiles = { "<node_internals>/**", "node_modules/**" },
      resolveSourceMapLocations = {
        "${workspaceFolder}/**",
        "!**/node_modules/**",
      },
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach to node process",
      cwd = vim.fn.getcwd(),
      processId = require("dap.utils").pick_process,
      sourceMaps = true,
    },
    {
      type = "pwa-chrome",
      request = "launch",
      name = "Launch & Debug Chrome",
      url = function ()
        local co = coroutine.running()
        return coroutine.create(function ()
          vim.ui.input({
            prompt = "Enter URL: ",
            default = "http://localhost:3000",
          }, function (url)
            if url == nil or url == "" then
              return
            else
              coroutine.resume(co, url)
            end
          end)
        end)
      end,
      webRoot = vim.fn.getcwd(),
      protocol = "inspector",
      sourceMaps = true,
      userDataDir = false,
    },
  }
end
