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
				completion = {
					workspaceWord = false,
					showWord = "Disable"
				}
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
			local handle = io.popen('poetry --directory ' .. workspace .. ' env info -p')
			local result = handle:read("*a")
			handle:close()
			local venv = vim.fn.trim(result)
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
moduleServer("web", "tailwindcss")
moduleServer("languages.dhall", "dhall_lsp_server")
moduleServer("languages.latex", "texlab")
moduleServer("grammar", "ltex", function()
	return {
		autostart = false,
		filetypes = { "bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex", "pandoc", "norg" },
		flags = { debounce_text_changes = 300 },
		settings = {
			ltex = {
				language = "en-GB",
				disabledRules = {
					["en"] = { "WHITESPACE_RULE" },
					["en-GB"] = { "WHITESPACE_RULE" },
					["pt-PT"] = { "WHITESPACE_RULE", "BARBARISMS_PT_PT_V3" },
				}
			},
		},
		handlers = {
			["textDocument/publishDiagnostics"] = vim.lsp.with(
				vim.lsp.diagnostic.on_publish_diagnostics, {
					-- Disable virtual_text
					virtual_text = false
				}
			),
		}
	}
end)
moduleServer("languages.astro", "astro", function()
	return {
		init_options = {
			typescript = {}
		},
	}
end)
moduleServer("languages.c", "clangd")
moduleServer("languages.matlab", "matlab_ls", function()
	return {
		settings = {
			MATLAB = {
				telemetry = false
			},
		}
	}
end)
moduleServer("languages.gdscript", "gdscript")
moduleServer("languages.jsonnet", "jsonnet_ls")

local capabilities = lsp_utils.get_capabilites()

for server, server_config in pairs(servers) do
	local base_config = {
		on_attach = lsp_utils.on_attach,
		capabilities = capabilities,
	}

	local config = utils.tableMerge(base_config, server_config)

	require('lspconfig')[server].setup(config)
end
