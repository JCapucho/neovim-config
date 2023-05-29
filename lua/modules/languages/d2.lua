if IsModuleEnabled("treesitter") then
	local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
	parser_config.d2 = {
		install_info = {
			url = 'https://git.pleshevski.ru/pleshevskiy/tree-sitter-d2',
			revision = 'main',
			files = { 'src/parser.c', 'src/scanner.cc' },
		},
		filetype = 'd2',
	};
end
