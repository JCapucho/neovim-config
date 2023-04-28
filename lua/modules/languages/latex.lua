vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.tex", "*.cls" },
	command = "set filetype=tex",
})
