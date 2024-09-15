require('telescope').setup()
require("which-key").add({
	{
		"<leader>,",
		function()
			require('telescope.builtin').buffers()
		end,
		desc = "Browse open buffers"
	},
	{
		"<leader>/",
		function()
			require('telescope.builtin').live_grep()
		end,
		desc = "Search in project's files"
	},
	{
		"<leader><space>",
		function()
			require('telescope.builtin').find_files()
		end,
		desc = "Browse project's files"
	},
	{
		"<leader>u",
		function()
			require("telescope").extensions.undo.undo()
		end,
		desc = "Navigate undo history"
	},
})
