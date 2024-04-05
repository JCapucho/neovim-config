local plugins = {}

if IsModuleEnabled('treesitter') then
	table.insert(plugins, {
		'calops/hmts.nvim',
		ft = { 'nix' },
	})
end

return plugins
