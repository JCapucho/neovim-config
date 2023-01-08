require('nightfox').setup({
	options = {
		module_default = false,
		transparent = true,
		modules = {
			whichkey = true,
			diagnostic = true,
			barbar = IsModuleEnabled('tabs'),
			telescope = IsModuleEnabled('telescope'),
			treesitter = IsModuleEnabled('treesitter'),
			tsrainbow = IsModuleEnabled('treesitter'),
			neogit = IsModuleEnabled('neogit'),
			cmp = IsModuleEnabled('completion'),
			dashboard = IsModuleEnabled('dashboard'),
			lsp_saga = IsModuleEnabled('lsp'),
		},
	},
})

vim.cmd.colorscheme('carbonfox')
