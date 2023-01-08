local use = require('packer').use

use({
	'uga-rosa/ccc.nvim',
	config = function()
		local ccc = require("ccc")
		ccc.setup()
	end
})
use({
	'windwp/nvim-ts-autotag',
	config = function()
		require('nvim-ts-autotag').setup()
	end
})
