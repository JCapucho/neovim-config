local function is_null_ls_formatting_enabled(bufnr)
	local file_type = vim.api.nvim_buf_get_option(bufnr, "filetype")
	local generators = require("null-ls.generators").get_available(
		file_type,
		require("null-ls.methods").internal.FORMATTING
	)
	return #generators > 0
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local function on_attach(client, bufnr)
	local null_ls_formats = is_null_ls_formatting_enabled(bufnr)

	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				if vim.g.formatOnSave then
					vim.lsp.buf.format({
						bufnr = bufnr,
						filter = function(formattingClient)
							-- apply whatever logic you want (in this example, we'll only use null-ls)
							return (not null_ls_formats) or formattingClient.name == "null-ls"
						end,
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
