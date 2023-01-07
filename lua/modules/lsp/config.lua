local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
	vim.notify("in")
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				if vim.g.formatOnSave then
					vim.lsp.buf.format({
						bufnr = bufnr,
					})
				end
			end,
		})
	end
end

local servers = {}

local function moduleServer(module, name, settings)
	if IsModuleEnabled(module) then
		servers[name] = settings or {}
	end
end

moduleServer("languages.lua", "sumneko_lua", {
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
})

local capabilities = vim.lsp.protocol.make_client_capabilities()

if IsModuleEnabled('completion') then
	capabilities = require('cmp_nvim_lsp').default_capabilities()
end

for server, settings in pairs(servers) do
	require('lspconfig')[server].setup({
		on_attach = on_attach,
		settings = settings,
		capabilities = capabilities,
	})
end
