return {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local dashboard = require("alpha.themes.dashboard")
        local btn = dashboard.button
        local section = dashboard.section

        section.header.val = {
            [[                                                 ]],
            [[                                                 ]],
            [[                                                 ]],
            [[                                                 ]],
            [[                                                 ]],
            [[                                                 ]],
            [[                                                 ]],
            [[                                                 ]],
            [[ ███╗  ██╗███████╗ █████╗ ██╗   ██╗██╗███╗   ███╗]],
            [[ ████╗ ██║██╔════╝██╔══██╗██║   ██║██║████╗ ████║]],
            [[ ██╔██╗██║█████╗  ██║  ██║╚██╗ ██╔╝██║██╔████╔██║]],
            [[ ██║╚████║██╔══╝  ██║  ██║ ╚████╔╝ ██║██║╚██╔╝██║]],
            [[ ██║ ╚███║███████╗╚█████╔╝  ╚██╔╝  ██║██║ ╚═╝ ██║]],
            [[ ╚═╝  ╚══╝╚══════╝ ╚════╝    ╚═╝   ╚═╝╚═╝     ╚═╝]],
            [[                                                 ]],
            [[                                                 ]],
            [[                                                 ]],
            [[                                                 ]],
        }

        section.buttons.val = {
            btn("o", " " .. " Current Session", "<cmd>lua require('persistence').load()<CR>"),
            btn("t", " " .. " File Tree", "<cmd>Neotree toggle<CR>"),
            btn("n", " " .. " New File", "<CMD>enew<CR>"),
            btn("r", " " .. " Last Session", "<cmd>lua require('persistence').load({ last = true })<CR>"),
            btn(".", " " .. " Dotfiles", "<CMD>cd $HOME/.dotfiles | NvimTreeToggle<CR>"),
            btn("q", " " .. " Quit", "<cmd>qa<CR>"),
        }

        vim.api.nvim_create_autocmd("User", {
            pattern = "LazyVimStarted",
            callback = function()
                local stats = require("lazy").stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                section.footer.val = "⚡Loaded " .. stats.count .. " plugins in " .. ms .. "ms"
                pcall(vim.cmd.AlphaRedraw)
            end,
        })

        section.footer.opts.hl = "Type"
        section.header.opts.hl = "Include"
        section.buttons.opts.hl = "Keyword"

        require("alpha").setup(dashboard.opts)
    end,
}
