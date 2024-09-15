local lspEnabled = IsModuleEnabled("lsp")

local function getLtexClient()
	local buf_clients = vim.lsp.get_clients()
	local client = nil
	for _, lsp in ipairs(buf_clients) do
		if lsp.name == "ltex" then
			client = lsp
		end
	end

	return client
end

local function enableSpellChecking(opts)
	local lang = opts.fargs[1]
	vim.opt_local.spell = true
	vim.opt_local.spelllang = lang

	if lspEnabled then
		require('modules.lsp.utils').server_patch_settings("ltex", function(settings)
			settings.ltex.language = lang
			return settings
		end)

		if getLtexClient() == nil then
			require("lspconfig").ltex.launch()
		end
	end
end

local function disableSpellChecking()
	vim.opt_local.spell = false

	if lspEnabled then
		vim.cmd("LspStop ltex")
		require('modules.lsp.utils').remove_server_patch_settings("ltex")
	end
end

vim.api.nvim_create_user_command('EnableSpellChecking', enableSpellChecking, { nargs = 1 })
vim.api.nvim_create_user_command('DisableSpellChecking', disableSpellChecking, {})

return {}
