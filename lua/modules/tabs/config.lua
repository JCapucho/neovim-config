require('bufferline').setup({
	animation = false,
	auto_hide = true,
	closable = false,
	icons = IsModuleEnabled('icons'),
})

-- Buffer navigation
require("which-key").register({
	["t"] = { "<Cmd>BufferNext<CR>", "Next buffer" },
	["T"] = { "<Cmd>BufferPrevious<CR>", "Previous buffer" },
}, { prefix = "g" })

require("which-key").register({
	b = {
		name = "buffer",
		["b"] = { "<Cmd>BufferPick<CR>", "Select a buffer" },
		["d"] = { "<Cmd>BufferClose<CR>", "Close the current buffer" },
		["o"] = { "<Cmd>BufferCloseAllButCurrent<CR>", "Close all buffers except current" },
		["k"] = { "<Cmd>BufferPickDelete<CR>", "Select a buffer to close" },
		["K"] = { "<Cmd>BufferCloseAllButPinned<CR>", "Close all buffers" },
	},
}, { prefix = "<leader>" })
