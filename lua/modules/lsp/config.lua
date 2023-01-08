local utils = require('modules.lsp.utils')

local servers = {}

local function moduleServer(module, name, lazySettings)
	if IsModuleEnabled(module) then
		local settings = {}

		if lazySettings ~= nil then
			settings = lazySettings()
		end

		servers[name] = settings
	end
end

moduleServer("languages.lua", "sumneko_lua", function()
	return {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	}
end)
moduleServer("languages.nix", "nil_ls", function()
	return {
		['nil'] = {
			formatting = {
				command = { "alejandra" },
			},
		},
	}
end)
moduleServer("languages.json", "jsonls", function()
	return {
		json = {
			schemas = require('schemastore').json.schemas(),
			validate = { enable = true },
		},
	}
end)
moduleServer("languages.python", "pyright", function()
	return {
		python = {
			analysis = {
				autoImportCompletions = true,
				useLibraryCodeForTypes = true,
				disableOrganizeImports = false,
			},
		},
	}
end)
moduleServer("web", "html")
moduleServer("web", "cssls")
moduleServer("web", "tsserver")

local capabilities = vim.lsp.protocol.make_client_capabilities()

if IsModuleEnabled('completion') then
	capabilities = require('cmp_nvim_lsp').default_capabilities()
end

for server, settings in pairs(servers) do
	require('lspconfig')[server].setup({
		on_attach = utils.on_attach,
		settings = settings,
		capabilities = capabilities,
	})
end
