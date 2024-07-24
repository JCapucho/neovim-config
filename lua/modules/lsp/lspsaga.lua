require('lspsaga').setup({
	preview = {
		lines_above = 5,
		lines_below = 5,
	},
	finder = {
		keys = {
			toggle_or_open = "<CR>",
		}
	},
	request_timeout = 2000,
})

vim.o.signcolumn = "no" -- Disable gutter

require("which-key").add({
	{ "<leader>c",  group = "code" },
	{ "<leader>cN", "<Cmd>Lspsaga diagnostic_jump_prev<CR>",  desc = "Jump to previous diagnostic" },
	{ "<leader>ca", "<Cmd>Lspsaga code_action<CR>",           desc = "Apply code action" },
	{ "<leader>cd", function() vim.lsp.buf.definition() end,  desc = "Goto definition" },
	{ "<leader>ce", "<Cmd>Lspsaga show_line_diagnostics<CR>", desc = "Show diagnostics in line" },
	{ "<leader>cf", "<Cmd>Lspsaga finder<CR>",                desc = "Find" },
	{ "<leader>ch", "<cmd>Lspsaga hover_doc<CR>",             desc = "Open documentation for current item" },
	{ "<leader>cn", "<Cmd>Lspsaga diagnostic_jump_next<CR>",  desc = "Jump to next diagnostic" },
	{ "<leader>co", "<Cmd>Lspsaga outline<CR>",               desc = "Open outline" },
	{ "<leader>cr", "<Cmd>Lspsaga rename<CR>",                desc = "Rename" },
})
