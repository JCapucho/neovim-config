local neogit = require('neogit')
neogit.setup({})

require("which-key").register({
	g = {
		name = "git",
		["g"] = { "<Cmd>Neogit<CR>", "Open neogit" },
	},
}, { prefix = "<leader>" })

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "NeogitStatus", "NeogitPopup" },
	callback = function() vim.opt_local.spell = false end,
})
