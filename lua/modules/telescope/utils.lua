return {
	check_rg_installed = function() return vim.fn.executable('rg') == 1 end,
	check_fd_installed = function() return vim.fn.executable('fd') == 1 end,
}
