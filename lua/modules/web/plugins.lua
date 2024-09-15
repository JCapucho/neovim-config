return {
	{
		'uga-rosa/ccc.nvim',
		config = function()
			local ccc = require("ccc")
			ccc.setup({
				auto_enable = true,
				lsp = IsModuleEnabled("lsp"),
			})
		end
	},
	'windwp/nvim-ts-autotag',
}
