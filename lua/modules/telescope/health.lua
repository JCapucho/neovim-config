local utils = require('modules.telescope.utils')

local M = {}

M.check = function()
	if not IsModuleEnabled('telescope') then
		vim.health.report_info("This module is disabled")
		return
	end

	vim.health.report_start("Capucho's config telescope report")

	if utils.check_rg_installed() then
		vim.health.report_ok("ripgrep is installed")
	else
		vim.health.report_error("ripgrep is not installed and is required")
	end

	if utils.check_fd_installed() then
		vim.health.report_ok("fd is installed")
	else
		vim.health.report_warn("fd is not installed and is strongly suggested as it improves the performance of telescope")
	end
end

return M
