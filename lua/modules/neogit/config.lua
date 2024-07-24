local neogit = require('neogit')
neogit.setup({})

require("which-key").add({
	{ "<leader>g",  group = "git" },
	{ "<leader>gg", "<Cmd>Neogit<CR>", desc = "Open neogit" },
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "NeogitStatus", "NeogitPopup" },
	callback = function() vim.opt_local.spell = false end,
})
