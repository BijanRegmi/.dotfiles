-- Upstream nvim-lspconfig lists `.git` as a fallback root marker (for
-- Tailwind v4), so the server attaches to any matching file (css, js, ts,
-- html, markdown, php, ...) in *any* git repo. Override root_dir to only
-- start when a real Tailwind/PostCSS config or a tailwindcss dependency exists.
return {
  root_dir = function (bufnr, on_dir)
    local util = require("lspconfig.util")
    local root_files = {
      "tailwind.config.js",
      "tailwind.config.cjs",
      "tailwind.config.mjs",
      "tailwind.config.ts",
      "postcss.config.js",
      "postcss.config.cjs",
      "postcss.config.mjs",
      "postcss.config.ts",
      -- Django
      "theme/static_src/tailwind.config.js",
      "theme/static_src/tailwind.config.cjs",
      "theme/static_src/tailwind.config.mjs",
      "theme/static_src/tailwind.config.ts",
      "theme/static_src/postcss.config.js",
    }
    local fname = vim.api.nvim_buf_get_name(bufnr)
    root_files = util.insert_package_json(root_files, "tailwindcss", fname)
    root_files = util.root_markers_with_field(root_files, { "mix.lock", "Gemfile.lock" }, "tailwind", fname)
    local found = vim.fs.find(root_files, { path = fname, upward = true })[1]
    if found then
      on_dir(vim.fs.dirname(found))
    end
  end,
}
