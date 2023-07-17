if IsModuleEnabled("treesitter") then
	local use = require('packer').use
	use('rush-rs/tree-sitter-asm')

	local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
	parser_config.asm = {
		install_info = {
			url = 'https://github.com/rush-rs/tree-sitter-asm.git',
			files = { 'src/parser.c' },
			branch = 'main',
		},
	};

	vim.treesitter.language.register('asm', 'mips')
end
