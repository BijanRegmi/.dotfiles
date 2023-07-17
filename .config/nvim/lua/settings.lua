local settings = {
    -- Create backup file
    backup = false,
    -- Disable creating swap file
    swapfile = false,
    -- File format
    fileformat = "unix",
    -- Encoding type
    encoding = "utf-8",
    -- File encoding type
    fileencoding = "utf-8",
    -- Set numbered lines
    number = true,
    -- Display line nr relative to current line
    relativenumber = true,
    -- Automatice indentation
    autoindent = true,
    smartindent = true,
    -- Number of spaces inserted for each indentation
    shiftwidth = 4,
    -- Convert tabs to spaces
    expandtab = true,
    -- Number of spaces for tab
    tabstop = 8,
    -- Always show tabs
    showtabline = 2,
    softtabstop = 0,
    -- Opens horizontal split to right
    splitright = true,
    -- Opens vertical split to down
    splitbelow = true,
    -- Pop up menu height
    pumheight = 10,
    -- Command height
    cmdheight = 2,
    -- Number of lines to leave at end
    scrolloff = 8,
    -- Faster completion
    updatetime = 100,
    -- Hide the mode we are in
    showmode = false,
    -- Copy paste between vim and everything
    clipboard = "unnamedplus",
    backspace = { "indent", "eol", "start" },
    -- Disbale cursor line
    cursorline = true,
    -- Enable sign column everytime
    signcolumn = "yes",
    -- Enable terminal colors
    termguicolors = true,
    mouse = 'a',
    foldenable = true,
    foldmethod = "indent"
}

for key, value in pairs(settings) do
    vim.opt[key] = value
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function(data)
        local real_file = vim.fn.filereadable(data.file) == 1
        local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

        local nvimTreeApi = require("nvim-tree.api")

        if real_file or no_name then
            nvimTreeApi.tree.toggle({ focus = false, find_file = true })
            return
        end

        local directory = vim.fn.isdirectory(data.file) == 1
        if directory then
            vim.cmd.cd(data.file)
            nvimTreeApi.tree.toggle({ focus = false, find_file = true })
            return
        end
    end
})
