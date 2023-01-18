local ensure_installed = {}

local function ensureGrammar(module, grammar)
	if IsModuleEnabled(module) then
		table.insert(ensure_installed, grammar)
	end
end

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
ensureGrammar('languages.python', 'python')

require('nvim-treesitter.configs').setup({
	ensure_installed = ensure_installed,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	rainbow = {
		enable = true,
		extended_mode = true,
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
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
})

require("which-key").register({
	o = { name = "object" },
}, { prefix = "<leader>" })
