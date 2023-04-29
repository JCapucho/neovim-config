local null_ls = require("null-ls")
local null_ls_utils = require("null-ls.utils")
local utils = require('modules.lsp.utils')

local sources = {}

if IsModuleEnabled("languages.python") then
	table.insert(sources, null_ls.builtins.formatting.black)
end

if IsModuleEnabled("web") then
	local fallbackPatterns = { "package.json", ".git" }
	local root_pattern = function(...)
		local fn = null_ls_utils.root_pattern(unpack(arg), unpack(fallbackPatterns))
		return function(params)
			return fn(params.bufname)
		end
	end

	table.insert(sources, null_ls.builtins.formatting.prettier.with({
		prefer_local = "node_modules/.bin",
		cwd = root_pattern("prettier.config.cjs", "prettier.config.js"),
	}))
	table.insert(sources, null_ls.builtins.code_actions.eslint.with({
		prefer_local = "node_modules/.bin",
		cwd = root_pattern(".eslintrc.cjs", ".eslintrc.js")
	}))
end

null_ls.setup({
	sources = sources,
	on_attach = utils.on_attach,
})
