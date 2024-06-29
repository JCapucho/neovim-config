if vim.g.neovide then
	vim.o.guifont = "JetBrainsMono Nerd Font:h11"
	vim.g.neovide_transparency = 0.8
	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0

	vim.g.neovide_scale_factor = 1.0
	vim.keymap.set("n", "<C-=>", function()
		vim.g.neovide_scale_factor = math.min(vim.g.neovide_scale_factor + 0.1, 2.5)
	end, { silent = true })
	vim.keymap.set("n", "<C-->", function()
		vim.g.neovide_scale_factor = math.max(vim.g.neovide_scale_factor - 0.1, 0.1)
	end, { silent = true })
end

-- Relative line numbers
vim.wo.number = true
vim.wo.relativenumber = true

vim.opt.clipboard = "unnamedplus" -- Use system's clipboard
vim.opt.undofile = true           -- Enable global undo persistence
vim.opt.ignorecase = true         -- Ignore case
-- Set the tab width to 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.g.editorconfig = true

vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "

vim.g.formatOnSave = true

vim.keymap.set("n", "<esc>", "<esc><cmd>noh<cr>", { silent = true })


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

return {
	'folke/which-key.nvim',
	'jghauser/mkdir.nvim',
	"kylechui/nvim-surround",
	'nmac427/guess-indent.nvim',
	'unblevable/quick-scope'
}
