local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local function on_attach(client, bufnr)
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

local function get_capabilites()
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	if IsModuleEnabled('completion') then
		capabilities = require('cmp_nvim_lsp').default_capabilities()
	end

	return capabilities
end

return { on_attach = on_attach, get_capabilites = get_capabilites }
