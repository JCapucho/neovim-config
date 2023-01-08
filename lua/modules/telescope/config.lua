local telescope = require('telescope')
local utils = require('modules.telescope.utils')

telescope.setup()

require("which-key").register({
	["<space>"] = {
		function()
			require('telescope.builtin').find_files()
		end,
		"Browse project's files"
	},
	["/"] = {
		function()
			require('telescope.builtin').live_grep()
		end,
		"Search in project's files"
	},
	["u"] = {
		function()
			require("telescope").extensions.undo.undo()
		end,
		"Navigate undo history"
	},
}, { prefix = "<leader>" })
