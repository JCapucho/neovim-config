local neogit = require('neogit')
neogit.setup({})

require("which-key").register({
	g = {
		name = "git",
		["g"] = { "<Cmd>Neogit<CR>", "Open neogit" },
	},
}, { prefix = "<leader>" })
