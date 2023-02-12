require("oil").setup()

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
