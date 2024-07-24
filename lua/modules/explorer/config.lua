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

require("which-key").add({
	{
		"<leader>.",
		function()
			require("oil").open_float()
		end,
		desc = "Open file explorer"
	},
})
