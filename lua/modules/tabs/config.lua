require('bufferline').setup({
	animation = false,
	auto_hide = true,
	icons = {
		button = false,
		modified = { button = false },
		filetype = { enabled = IsModuleEnabled('icons') }
	},
})

-- Buffer navigation
require("which-key").add({
	{ "gT",         "<Cmd>BufferPrevious<CR>",           desc = "Previous buffer" },
	{ "gt",         "<Cmd>BufferNext<CR>",               desc = "Next buffer" },

	{ "<leader>b",  group = "buffer" },
	{ "<leader>bK", "<Cmd>BufferCloseAllButPinned<CR>",  desc = "Close all buffers" },
	{ "<leader>bb", "<Cmd>BufferPick<CR>",               desc = "Select a buffer" },
	{ "<leader>bd", "<Cmd>BufferClose<CR>",              desc = "Close the current buffer" },
	{ "<leader>bk", "<Cmd>BufferPickDelete<CR>",         desc = "Select a buffer to close" },
	{ "<leader>bo", "<Cmd>BufferCloseAllButCurrent<CR>", desc = "Close all buffers except current" },
})
