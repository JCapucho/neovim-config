local jdtls = require('jdtls')
local utils = require('utils')
local lsp_utils = require('modules.lsp.utils')

local cmd = utils.findExecutable({ 'jdtls', 'jdt-language-server' })
local root = require('jdtls.setup').find_root({ 'mvnw', 'gradlew', '.git' })
local data_dir = utils.cache_dir .. "/jdtls-workspaces" .. root

local capabilities = lsp_utils.get_capabilites()

local config = {
	cmd = { cmd, '-data', data_dir },
	on_attach = lsp_utils.on_attach,
	root_dir = root,
	capabilities = capabilities,
	init_options = {
		extendedCapabilities = jdtls.extendedClientCapabilities,
	},
}

jdtls.start_or_attach(config)
