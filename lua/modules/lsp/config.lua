local utils = require('utils')
local lsp_utils = require('modules.lsp.utils')

local servers = {}

local function moduleServer(module, name, lazyConfig)
	if IsModuleEnabled(module) then
		local server_config = {}

		if lazyConfig ~= nil then
			server_config = lazyConfig()
		end

		servers[name] = server_config
	end
end

moduleServer("languages.lua", "lua_ls", function()
	return {
		settings = {
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
	}
end)
moduleServer("languages.nix", "nil_ls", function()
	return {
		settings = {
			['nil'] = {
				formatting = {
					command = { "alejandra" },
				},
			},
		}
	}
end)
moduleServer("languages.json", "jsonls", function()
	return {
		settings = {
			json = {
				schemas = require('schemastore').json.schemas(),
				validate = { enable = true },
			},
		}
	}
end)
moduleServer("languages.python", "pyright", function()
	local path = require('lspconfig/util').path

	local function get_python_path(workspace)
		-- Use activated virtualenv.
		if vim.env.VIRTUAL_ENV then
			return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
		end

		-- Find and use virtualenv in workspace directory.
		for _, pattern in ipairs({ '*', '.*' }) do
			local match = vim.fn.glob(path.join(workspace, pattern, 'pyvenv.cfg'))
			if match ~= '' then
				return path.join(path.dirname(match), 'bin', 'python')
			end
		end

		-- Find and use virtualenv via poetry in workspace directory.
		local match = vim.fn.glob(path.join(workspace, 'poetry.lock'))
		if match ~= '' then
			local venv = vim.fn.trim(vim.fn.system('poetry --directory ' .. workspace .. ' env info -p'))
			return path.join(venv, 'bin', 'python')
		end

		-- Fallback to system Python.
		return utils.findExecutable({ 'python3', 'python' })
	end

	return {
		before_init = function(_, config)
			config.settings.python.pythonPath = get_python_path(config.root_dir)
		end,
		settings = {
			python = {
				analysis = {
					autoImportCompletions = true,
					useLibraryCodeForTypes = true,
					disableOrganizeImports = false,
				},
			},
		}
	}
end)
moduleServer("web", "html")
moduleServer("web", "cssls")
moduleServer("web", "tsserver")

local capabilities = lsp_utils.get_capabilites()

for server, server_config in pairs(servers) do
	local base_config = {
		on_attach = lsp_utils.on_attach,
		capabilities = capabilities,
	}

	local config = utils.tableMerge(base_config, server_config)

	require('lspconfig')[server].setup(config)
end
