require('nightfox').setup({
	options = {
		module_default = false,
		transparent = true,
		modules = {
			whichkey = true,
			barbar = IsModuleEnabled('tabs'),
			telescope = IsModuleEnabled('telescope'),
			treesitter = IsModuleEnabled('treesitter'),
			neogit = IsModuleEnabled('neogit'),
			cmp = IsModuleEnabled('completion'),
			dashboard = IsModuleEnabled('dashboard'),
		},
	},
})

vim.cmd.colorscheme('carbonfox')
