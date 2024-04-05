return {
	'mfussenegger/nvim-jdtls',
	ft = 'java',
	config = function()
		require('modules.languages.java.config')
	end
}
