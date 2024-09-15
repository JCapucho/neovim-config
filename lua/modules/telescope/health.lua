local utils = require('modules.telescope.utils')

local M = {}

M.check = function()
	if not IsModuleEnabled('telescope') then
		vim.health.info("This module is disabled")
		return
	end

	vim.health.start("Capucho's config telescope report")

	if utils.check_rg_installed() then
		vim.health.ok("ripgrep is installed")
	else
		vim.health.error("ripgrep is not installed and is required")
	end

	if utils.check_fd_installed() then
		vim.health.ok("fd is installed")
	else
		vim.health.warn("fd is not installed and is strongly suggested as it improves the performance of telescope")
	end
end

return M
