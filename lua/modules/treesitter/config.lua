local ensure_installed = { "query" }

local function ensureGrammar(module, grammar)
	if IsModuleEnabled(module) then
		table.insert(ensure_installed, grammar)
	end
end

-- Needed for lspsaga
ensureGrammar('lsp', 'markdown')
ensureGrammar('lsp', 'markdown_inline')

ensureGrammar('web', 'css')
ensureGrammar('web', 'tsx')
ensureGrammar('web', 'html')
ensureGrammar('web', 'javascript')
ensureGrammar('web', 'typescript')

ensureGrammar('neogit', 'gitcommit')
ensureGrammar('neogit', 'gitignore')
ensureGrammar('neogit', 'gitattributes')
ensureGrammar('neogit', 'git_rebase')

ensureGrammar('languages.nix', 'nix')
ensureGrammar('languages.lua', 'lua')
ensureGrammar('languages.rust', 'rust')
ensureGrammar('languages.json', 'json')
ensureGrammar('languages.java', 'java')
ensureGrammar('languages.dhall', 'dhall')
ensureGrammar('languages.python', 'python')
ensureGrammar('languages.d2', 'd2')
ensureGrammar('languages.astro', 'astro')
ensureGrammar('languages.asm', 'asm')
ensureGrammar('languages.latex', 'latex')
ensureGrammar('languages.go', 'go')
ensureGrammar('languages.go', 'gomod')
ensureGrammar('languages.c', 'c')
ensureGrammar('languages.fish', 'fish')
ensureGrammar('languages.bash', 'bash')

require('nvim_context_vt').setup({
	disable_virtual_lines = true,
})

require('nvim-treesitter.configs').setup({
	ensure_installed = ensure_installed,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["aa"] = "@attribute.outer",
				["af"] = "@function.outer",
				["as"] = "@class.outer",
				["ab"] = "@block.outer",
				["ac"] = "@call.outer",
				["ap"] = "@parameter.outer",
				["ia"] = "@attribute.inner",
				["if"] = "@function.inner",
				["is"] = "@class.inner",
				["ib"] = "@block.inner",
				["ic"] = "@call.inner",
				["ip"] = "@parameter.inner",
				["oc"] = "@comment.outer",
				["os"] = "@statement.outer",
			},
			include_surrounding_whitespace = true,
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>oa"] = "@parameter.inner",
				["<leader>oc"] = "@comment.outer",
				["<leader>os"] = "@statement.outer",
			},
			swap_previous = {
				["<leader>oA"] = "@parameter.inner",
				["<leader>oC"] = "@comment.outer",
				["<leader>oS"] = "@statement.outer",
			},
		},
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				["]f"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]F"] = "@function.outer",
				["]}"] = "@class.outer",
			},
			goto_previous_start = {
				["[f"] = "@function.outer",
				["[{"] = "@class.outer",
			},
			goto_previous_end = {
				["[F"] = "@function.outer",
				["[{"] = "@class.outer",
			},
		},
	},
	query_linter = {
		enable = true,
		use_virtual_text = true,
		lint_events = { "BufWrite", "CursorHold" },
	},
})

local rainbow_delimiters = require 'rainbow-delimiters'
require('rainbow-delimiters.setup')({
	strategy = {
		[''] = rainbow_delimiters.strategy['global'],
	},
	query = {
		[''] = 'rainbow-delimiters',
		javascript = 'rainbow-delimiters-react',
		jsx = 'rainbow-delimiters-react',
		tsx = 'rainbow-delimiters-react',
		latex = 'rainbow-blocks',
		lua = 'rainbow-blocks',
		verilog = 'rainbow-blocks',
	},
	highlight = {
		'RainbowDelimiterRed',
		'RainbowDelimiterYellow',
		'RainbowDelimiterBlue',
		'RainbowDelimiterOrange',
		'RainbowDelimiterGreen',
		'RainbowDelimiterViolet',
		'RainbowDelimiterCyan',
	},
})

vim.g.skip_ts_context_commentstring_module = true;

require('ts_context_commentstring').setup({
	enable_autocmd = false,
	languages = {
		d2 = '# %s',
	},
})

require("which-key").register({
	o = { name = "object" },
}, { prefix = "<leader>" })
