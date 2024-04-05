if not IsModuleEnabled('treesitter') then
	error('Neorg requires the treesitter module')
end

return {
	{
		"vhyrro/luarocks.nvim",
		priority = 1000, -- We'd like this plugin to load first out of the rest
		config = true, -- This automatically runs `require("luarocks-nvim").setup()`
	},
	{
		"nvim-neorg/neorg",
		dependencies = { "luarocks.nvim" },
		version = "*",
		config = function()
			local modules = {
				["core.defaults"] = {},
				["core.export"] = {},
				["core.export.markdown"] = {}
			}

			if IsModuleEnabled('completion') then
				modules["core.completion"] = {
					config = { engine = 'nvim-cmp' }
				}
			end

			require("neorg").setup({
				load = modules
			})
		end
	}
}
