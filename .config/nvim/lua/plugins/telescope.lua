local keyopts = require("config.utils").keymap.opts
local icons = require("config.utils").icons.telescope

return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = "Telescope",
	init = function(_)
		vim.keymap.set("n", "<C-f>", ":Telescope find_files<CR>", keyopts("Telescope find files"))
		vim.keymap.set("n", "<C-g>", ":Telescope live_grep<CR>", keyopts("Telescope live grep"))
	end,
	opts = {
		defaults = {
			prompt_prefix = icons.prompt_prefix,
			selection_caret = icons.selection_caret,
			path_display = {
				"filename_first",
			},
		},
		pickers = {
			find_files = {
				theme = "dropdown",
				hidden = true,
				path_display = { filename_first = { reverse_directories = false } },
			},
		},
	},
	config = function(_, opts)
		require("telescope").setup(opts)
		require("telescope").load_extension("flutter")
	end,
}
