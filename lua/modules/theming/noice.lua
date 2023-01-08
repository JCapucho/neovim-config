require("noice").setup({
	cmdline = {
		enabled = true,
		view = "cmdline_popup",
		opts = {
			position = { row = "50%", col = "50%" },
			size = { width = 60, height = "auto" },
		},
		format = {
			cmdline = { pattern = "^:", icon = ":", lang = "vim" },
			search_down = { kind = "search", pattern = "^/", icon = "/", lang = "regex" },
			search_up = { kind = "search", pattern = "^%?", icon = "/", lang = "regex" },
			filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
			lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
			help = { pattern = "^:%s*he?l?p?%s+", icon = "?" },
			input = {},
		},
	},
	popupmenu = {
		enabled = true, -- enables the Noice popupmenu UI
		backend = "cmp", -- backend to use to show regular cmdline completions
	},
	lsp = {
		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
})
