require('lspsaga').setup({
	preview = {
		lines_above = 5,
		lines_below = 5,
	},
	request_timeout = 2000,
})

vim.o.signcolumn = "no" -- Disable gutter

require("which-key").register({
	c = {
		name = "code",
		["f"] = { "<Cmd>Lspsaga lsp_finder<CR>", "Find" },
		["a"] = { "<Cmd>Lspsaga code_action<CR>", "Apply code action" },
		["r"] = { "<Cmd>Lspsaga rename<CR>", "Rename" },
		["d"] = { function() vim.lsp.buf.definition() end, "Goto definition" },
		["h"] = { "<cmd>Lspsaga hover_doc<CR>", "Open documentation for current item" },
		["e"] = { "<Cmd>Lspsaga show_line_diagnostics<CR>", "Show diagnostics in line" },
		["n"] = { "<Cmd>Lspsaga diagnostic_jump_next<CR>", "Jump to next diagnostic" },
		["N"] = { "<Cmd>Lspsaga diagnostic_jump_prev<CR>", "Jump to previous diagnostic" },
		["o"] = { "<Cmd>Lspsaga outline<CR>", "Open outline" },
	},
}, { prefix = "<leader>" })
