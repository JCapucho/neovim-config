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

	-- Avoid null-ls breaking the formatexpr if no formatting source is available
	--
	-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts#avoid-breaking-formatexpr-ie-gq
	if client.server_capabilities.documentFormattingProvider then
		if
			client.name == "null-ls" and null_ls_formats or client.name ~= "null-ls"
		then
			vim.bo[bufnr].formatexpr = "v:lua.vim.lsp.formatexpr()"
		else
			vim.bo[bufnr].formatexpr = nil
		end
	end
end

local function get_capabilites()
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	if IsModuleEnabled('completion') then
		capabilities = require('cmp_nvim_lsp').default_capabilities()
	end

	return capabilities
end

local function server_patch_settings(server_name, settings_patcher)
	local bufnr = vim.api.nvim_buf_get_number(0)
	local augroup_settings = vim.api.nvim_create_augroup(string.format('LspSettings-%s', server_name), {})
	vim.api.nvim_clear_autocmds({ group = augroup_settings, buffer = bufnr })

	local function patch_settings(client)
		client.config.settings = settings_patcher(client.config.settings)
		client.notify("workspace/didChangeConfiguration", {
			settings = client.config.settings,
		})
	end

	local clients = vim.lsp.get_active_clients({ name = server_name })
	if #clients > 0 then
		patch_settings(clients[1])
		return
	end

	vim.api.nvim_create_autocmd("LspAttach", {
		group = augroup_settings,
		buffer = bufnr,
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if client.name == server_name then
				patch_settings(client)
				return true
			end
		end,
	})
end

local function remove_server_patch_settings(server_name)
	local bufnr = vim.api.nvim_buf_get_number(0)
	local augroup_settings = vim.api.nvim_create_augroup(string.format('LspSettings-%s', server_name), {})
	vim.api.nvim_clear_autocmds({ group = augroup_settings, buffer = bufnr })
end

return {
	on_attach = on_attach,
	get_capabilites = get_capabilites,
	server_patch_settings = server_patch_settings,
	remove_server_patch_settings = remove_server_patch_settings
}
