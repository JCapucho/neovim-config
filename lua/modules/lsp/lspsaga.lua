local saga = require("lspsaga")
saga.init_lsp_saga({
	preview_lines_above = 5,
	max_preview_lines = 5,
	code_action_lightbulb = {
		sign = false,
	},
})

vim.diagnostic.config({ signs = false })

require("which-key").register({
	c = {
		name = "code",
		["f"] = { "<Cmd>Lspsaga lsp_finder<CR>", "Find" },
		["a"] = { "<Cmd>Lspsaga code_action<CR>", "Apply code action" },
		["r"] = { "<Cmd>Lspsaga rename<CR>", "Rename" },
		["d"] = { function() vim.lsp.buf.definition() end, "Goto definition" },
		["h"] = {
			function() vim.lsp.buf.hover() end,
			"Open documentation for current item"
		},
		["e"] = { "<Cmd>Lspsaga show_line_diagnostics<CR>", "Show diagnostics in line" },
		["E"] = { "<Cmd>Lspsaga show_cursor_diagnostics<CR>", "Show diagnostics under cursor" },
		["n"] = { "<Cmd>Lspsaga diagnostic_jump_next<CR>", "Jump to next diagnostic" },
		["N"] = { "<Cmd>Lspsaga diagnostic_jump_prev<CR>", "Jump to previous diagnostic" },
		["o"] = { "<Cmd>LSoutlineToggle<CR>", "Open outline" },
	},
}, { prefix = "<leader>" })
