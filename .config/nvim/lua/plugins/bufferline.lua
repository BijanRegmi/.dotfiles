return {
    'akinsho/bufferline.nvim',
    tag = "v3.*",
    event = 'VeryLazy',
    opts = {
        options = {
            mode = "buffers",
            numbers = "ordinal",
            close_command = "bdelete! %d",
            right_mouse_command = "bdelete! %d",
            left_mouse_command = "buffer %d",
            middle_mouse_command = nil,
            indicator = { icon = '|', style = 'icon' },
            buffer_close_icon = '',
            modified_icon = '●',
            close_icon = '',
            left_trunc_marker = '',
            right_trunc_marker = '',
            name_formatter = function(buf)
                return vim.fn.fnamemodify(buf.path, ':p:t')
            end,
            max_name_length = 20,
            max_prefix_length = 15,
            tab_size = 10,
            diagnostics = false,
            diagnostics_update_in_insert = false,
            diagnostics_indicator = function(count, level, diagnostics_dict,
                                             context)
                return "(" .. count .. ")"
            end,
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "Explorer",
                    text_align = "center"
                }
            },
            color_icons = true,
            show_buffer_icons = true,
            show_buffer_close_icons = true,
            show_buffer_default_icon = true,
            show_close_icon = true,
            show_tab_indicators = true,
            persist_buffer_sort = true,
            separator_style = "slant",
            enforce_regular_tabs = false,
            always_show_bufferline = true,
            sort_by = 'insert_after_current'
        }
    }
}
