-- Adapted from: https://github.com/EdenEast/nightfox.nvim/blob/6677c99d89050fa940ffc320fe780fb52baa68ac/misc/feline.lua

local fmt = string.format
vim.opt.termguicolors = true

----------------------------------------------------------------------------------------------------
-- Colors

---Convert color number to hex string
---@param n number
---@return string
local hex = function(n)
	if n then
		return fmt("#%06x", n)
	end
end

---Parse `style` string into nvim_set_hl options
---@param style string
---@return table
local function parse_style(style)
	if not style or style == "NONE" then
		return {}
	end

	local result = {}
	for token in string.gmatch(style, "([^,]+)") do
		result[token] = true
	end

	return result
end

---Get highlight opts for a given highlight group name
---@param name string
---@return table
local function get_highlight(name)
	local hl = vim.api.nvim_get_hl_by_name(name, true)
	if hl.link then
		return get_highlight(hl.link)
	end

	local result = parse_style(hl.style)
	result.fg = hl.foreground and hex(hl.foreground)
	result.bg = hl.background and hex(hl.background)
	result.sp = hl.special and hex(hl.special)

	return result
end

---Set highlight group from provided table
---@param groups table
local function set_highlights(groups)
	for group, opts in pairs(groups) do
		vim.api.nvim_set_hl(0, group, opts)
	end
end

---Generate a color palette from the current applied colorscheme
---@return table
local function generate_pallet_from_colorscheme()
	-- stylua: ignore
	local color_map = {
		black   = { index = 0, default = "#393b44" },
		red     = { index = 1, default = "#c94f6d" },
		green   = { index = 2, default = "#81b29a" },
		yellow  = { index = 3, default = "#dbc074" },
		blue    = { index = 4, default = "#719cd6" },
		magenta = { index = 5, default = "#9d79d6" },
		cyan    = { index = 6, default = "#63cdcf" },
		white   = { index = 7, default = "#dfdfe0" },
	}

	local diagnostic_map = {
		hint = { hl = "DiagnosticHint", default = color_map.green.default },
		info = { hl = "DiagnosticInfo", default = color_map.blue.default },
		warn = { hl = "DiagnosticWarn", default = color_map.yellow.default },
		error = { hl = "DiagnosticError", default = color_map.red.default },
	}

	local pallet = {}
	for name, value in pairs(color_map) do
		local global_name = "terminal_color_" .. value.index
		pallet[name] = vim.g[global_name] and vim.g[global_name] or value.default
	end

	for name, value in pairs(diagnostic_map) do
		pallet[name] = get_highlight(value.hl).fg or value.default
	end

	pallet.sl = get_highlight("StatusLine")
	pallet.sel = get_highlight("TabLineSel")

	return pallet
end

---Generate user highlight groups based on the curent applied colorscheme
---
---NOTE: This is a global because I dont known where this file will be in your config
---and it is needed for the autocmd below
_G._generate_user_statusline_highlights = function()
	local pal = generate_pallet_from_colorscheme()

	-- stylua: ignore
	local sl_colors = {
		Black   = { fg = pal.black, bg = pal.white },
		Red     = { fg = pal.red, bg = pal.sl.bg },
		Green   = { fg = pal.green, bg = pal.sl.bg },
		Yellow  = { fg = pal.yellow, bg = pal.sl.bg },
		Blue    = { fg = pal.blue, bg = pal.sl.bg },
		Magenta = { fg = pal.magenta, bg = pal.sl.bg },
		Cyan    = { fg = pal.cyan, bg = pal.sl.bg },
		White   = { fg = pal.white, bg = pal.black },
	}

	local colors = {}
	for name, value in pairs(sl_colors) do
		colors["User" .. name] = { fg = value.fg, bg = value.bg, bold = true }
		colors["UserRv" .. name] = { fg = value.bg, bg = value.fg, bold = true }
	end

	local status = vim.o.background == "dark" and { fg = pal.black, bg = pal.white } or { fg = pal.white, bg = pal.black }

	local groups = {
		-- statusline
		UserSLHint = { fg = pal.sl.bg, bg = pal.hint, bold = true },
		UserSLInfo = { fg = pal.sl.bg, bg = pal.info, bold = true },
		UserSLWarn = { fg = pal.sl.bg, bg = pal.warn, bold = true },
		UserSLError = { fg = pal.sl.bg, bg = pal.error, bold = true },
		UserSLStatus = { fg = status.fg, bg = status.bg, bold = true },

		UserSLFtHint = { fg = pal.sel.bg, bg = pal.hint },
		UserSLHintInfo = { fg = pal.hint, bg = pal.info },
		UserSLInfoWarn = { fg = pal.info, bg = pal.warn },
		UserSLWarnError = { fg = pal.warn, bg = pal.error },
		UserSLErrorStatus = { fg = pal.error, bg = status.bg },
		UserSLStatusBg = { fg = status.bg, bg = pal.sl.bg },

		UserSLAlt = pal.sel,
		UserSLAltSep = { fg = pal.sl.bg, bg = pal.sel.bg },
		UserSLGitBranch = { fg = pal.yellow, bg = pal.sl.bg },
	}

	set_highlights(vim.tbl_extend("force", colors, groups))
end

_generate_user_statusline_highlights()

vim.api.nvim_create_augroup("UserStatuslineHighlightGroups", { clear = true })
vim.api.nvim_create_autocmd({ "SessionLoadPost", "ColorScheme" }, {
	callback = function()
		_generate_user_statusline_highlights()
	end,
})

----------------------------------------------------------------------------------------------------
-- Feline

local vi = {
	-- Map vi mode to text name
	text = {
		n = "NORMAL",
		no = "NORMAL",
		i = "INSERT",
		v = "VISUAL",
		V = "V-LINE",
		[""] = "V-BLOCK",
		c = "COMMAND",
		cv = "COMMAND",
		ce = "COMMAND",
		R = "REPLACE",
		Rv = "REPLACE",
		s = "SELECT",
		S = "SELECT",
		[""] = "SELECT",
		t = "TERMINAL",
	},

	-- Maps vi mode to highlight group color defined above
	colors = {
		n = "UserRvCyan",
		no = "UserRvCyan",
		i = "UserRvGreen",
		v = "UserRvMagenta",
		V = "UserRvMagenta",
		[""] = "UserRvMagenta",
		R = "UserRvRed",
		Rv = "UserRvRed",
		r = "UserRvBlue",
		rm = "UserRvBlue",
		s = "UserRvMagenta",
		S = "UserRvMagenta",
		[""] = "FelnMagenta",
		c = "UserRvYellow",
		["!"] = "UserRvBlue",
		t = "UserRvBlue",
	},
}

---Get the number of diagnostic messages for the provided severity
---@param str string [ERROR | WARN | INFO | HINT]
---@return string
local function get_diag(str, label)
	local diagnostics = vim.diagnostic.get(0, { severity = vim.diagnostic.severity[str] })
	local count = #diagnostics

	return (count > 0) and " " .. label .. "-" .. count .. " " or ""
end

---Get highlight group from vi mode
---@return string
local function vi_mode_hl()
	return vi.colors[vim.fn.mode()] or "UserSLViBlack"
end

-- Create a table that contians every status line commonent
local c = {
	vimode = {
		provider = function()
			return fmt(" %s ", vi.text[vim.fn.mode()])
		end,
		hl = vi_mode_hl,
	},
	file_type = {
		provider = function()
			return fmt(" %s ", vim.bo.filetype)
		end,
		hl = "UserSLAlt",
	},
	fileinfo = {
		provider = {
			name = "file_info",
			opts = {
				type = "unique",
				file_modified_icon = "[+]",
				file_readonly_icon = "[RO]",
			},
		},
		hl = "UserSLAlt",
		left_sep = { str = " ", hl = "UserSLAltSep" },
		right_sep = { str = " ", hl = "UserSLAltSep" },
		icon = "",
	},
	file_enc = {
		provider = function()
			if vim.bo.fileencoding ~= "utf-8" then
				return fmt(" %s ", vim.bo.fileencoding)
			else
				return ""
			end
		end,
		hl = "StatusLine",
	},
	position = {
		provider = function()
			return fmt(" %3d:%-2d ", unpack(vim.api.nvim_win_get_cursor(0)))
		end,
		hl = vi_mode_hl,
	},
	default = { -- needed to pass the parent StatusLine hl group to right hand side
		provider = "",
		hl = "StatusLine",
	},
	lsp_status = {
		provider = function()
			return vim.tbl_count(vim.lsp.buf_get_clients(0)) == 0 and "" or " LSP "
		end,
		hl = function()
			return vim.tbl_count(vim.lsp.buf_get_clients(0)) == 0 and "UserRvRed" or "UserRvGreen"
		end,
	},
	lsp_error = {
		provider = function()
			return get_diag("ERROR", "E")
		end,
		hl = "UserSLError",
	},
	lsp_warn = {
		provider = function()
			return get_diag("WARN", "W")
		end,
		hl = "UserSLWarn",
	},
	lsp_info = {
		provider = function()
			return get_diag("INFO", "I")
		end,
		hl = "UserSLInfo",
	},
	lsp_hint = {
		provider = function()
			return get_diag("HINT", "H")
		end,
		hl = "UserSLHint",
	},
}

local active = {
	{ -- left
		c.vimode,
		c.fileinfo,
		c.default, -- must be last
	},
	{ -- right
		c.lsp_error,
		c.lsp_warn,
		c.lsp_info,
		c.lsp_hint,
		c.lsp_status,
		c.file_type,
		c.file_enc,
		c.position,
	},
}

local inactive = {
	{ -- left
		c.file_type,
		c.default, -- must be last
	},
	{ c.position }, -- right
}

require("feline").setup({
	components = { active = active, inactive = inactive },
	highlight_reset_triggers = {},
	force_inactive = {
		filetypes = {
			"NvimTree",
			"packer",
			"dap-repl",
			"dapui_scopes",
			"dapui_stacks",
			"dapui_watches",
			"dapui_repl",
			"LspTrouble",
			"qf",
			"help",
		},
		buftypes = { "terminal" },
		bufnames = {},
	},
	disable = {
		filetypes = {
			"dashboard",
			"startify",
		},
	},
})
