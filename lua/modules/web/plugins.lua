return {
	{
		'uga-rosa/ccc.nvim',
		config = function()
			local ccc = require("ccc")
			ccc.setup({
				auto_enable = true,
				-- TODO: Disabled temporarily
				lsp = false,
			})
		end
	},
	'windwp/nvim-ts-autotag',
}
