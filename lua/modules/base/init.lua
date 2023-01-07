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

use({
	'folke/which-key.nvim',
	config = function()
		require("which-key").setup()
	end
})
use({ 'jghauser/mkdir.nvim' }) -- Automatically create missing folders on save
