local null_ls = require("null-ls")
local utils = require('modules.lsp.utils')

local sources = {}

if IsModuleEnabled("languages.python") then
	table.insert(sources, null_ls.builtins.formatting.black)
end

if IsModuleEnabled("web") then
	table.insert(sources, null_ls.builtins.formatting.prettier)
	table.insert(sources, null_ls.builtins.code_actions.eslint)
end

null_ls.setup({
	sources = sources,
	on_attach = utils.on_attach,
})
