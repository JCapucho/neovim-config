local use = require('packer').use

use({
	'Olical/conjure',
	config = function()
		require('modules.repl.config')
	end
})
