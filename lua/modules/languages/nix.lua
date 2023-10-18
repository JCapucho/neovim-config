local use = require('packer').use

if IsModuleEnabled('treesitter') then
	use({
		'calops/hmts.nvim',
		ft = { 'nix' },
	})
end
