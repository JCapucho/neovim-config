local null_ls = require("null-ls")
local utils = require('modules.lsp.utils')

local sources = {
	null_ls.builtins.completion.spell,
}

if IsModuleEnabled("languages.python") then
	table.insert(sources, null_ls.builtins.formatting.black)
end

null_ls.setup({
	sources = sources,
	on_attach = utils.on_attach,
})
