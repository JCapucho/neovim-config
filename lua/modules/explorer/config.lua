require("oil").setup({
	skip_confirm_for_simple_edits = true,
	keymaps = {
		["q"] = "actions.close",
		["<C-h>"] = "actions.parent",
		["<C-l>"] = "actions.select",
	},
})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("which-key").register({
	["."] = {
		function()
			require("oil").open_float()
		end,
		"Open file explorer"
	},
}, { prefix = "<leader>" })
