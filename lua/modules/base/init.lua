local use = require('packer').use

if vim.g.neovide then
	vim.o.guifont = "JetBrainsMono Nerd Font:h11"
	vim.g.neovide_transparency = 0.8
	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0
end

vim.opt.clipboard = "unnamedplus" -- Use system's clipboard
vim.opt.undofile = true           -- Enable global persistence
vim.opt.ignorecase = true         -- Ignore case
-- Set the tab width to 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.g.editorconfig = true

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

		local ft = require('Comment.ft')
		ft.d2 = '#%s'
	end
})

use({
	'nmac427/guess-indent.nvim',
	config = function()
		require('guess-indent').setup({})
	end,
})

vim.filetype.add({
	extension = {
		vert = 'glsl',
		frag = 'glsl',
		comp = 'glsl',
		dhall = 'dhall',
		d2 = 'd2',
		mdx = "markdown.mdx",
		mips = 'mips'
	}
})
