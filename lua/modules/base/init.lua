local use = require('packer').use

vim.opt.clipboard = "unnamedplus" -- Use system's clipboard
vim.opt.undofile = true -- Enable global persistence
vim.opt.ignorecase = true -- Ignore case
-- Set the tab width to 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.g.editorconfig_enable = true

vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "

vim.g.formatOnSave = true

vim.keymap.set("n", "<esc>", "<esc><cmd>noh<cr>", { silent = true })

use({
	'folke/which-key.nvim',
	config = function()
		require("which-key").setup()
	end
})
use({ 'jghauser/mkdir.nvim' }) -- Automatically create missing folders on save
use({
	"kylechui/nvim-surround",
	config = function()
		require("nvim-surround").setup()
	end
})

local commentAfter = {}

if IsModuleEnabled('treesitter') then
	table.insert(commentAfter, 'nvim-ts-context-commentstring')
end

use({
	'numToStr/Comment.nvim',
	after = commentAfter,
	config = function()
		local config = {}

		if IsModuleEnabled('treesitter') then
			config = {
				pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
			}
		end

		require('Comment').setup(config)
	end
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.vert", "*.frag", "*.comp" },
	command = "set filetype=glsl",
})
