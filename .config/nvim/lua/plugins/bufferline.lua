return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
    opts = {
        options = {
            buffer_close_icon = "",
            name_formatter = function(buf)
                return vim.fn.fnamemodify(buf.path, ":p:t")
            end,
            max_name_length = 18,
            diagnostics = "nvim_lsp",
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "Explorer",
                    text_align = "center",
                    separator = true,
                },
            },
            color_icons = true,
            separator_style = "slant",
        },
    },
}
