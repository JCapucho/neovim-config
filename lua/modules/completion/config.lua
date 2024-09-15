local cmp = require('cmp')
local cmp_buffer = require('cmp_buffer')

local sources = {
	{},
	{
		{ name = 'path' },
	},
	{
		{ name = 'buffer' },
	},
	{
		{ name = 'emoji' },
		{
			name = 'spell',
			option = {
				enable_in_context = function()
					return require('cmp.config.context').in_treesitter_capture('spell')
				end,
			}
		},
	}
}

if IsModuleEnabled('lsp') then
	table.insert(sources[1], { name = 'nvim_lsp' })
end

table.insert(sources[1], { name = 'luasnip' })

cmp.setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	window = {
		completion = {
			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
			col_offset = -3,
			side_padding = 0,
		},
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<C-j>'] = cmp.mapping.select_next_item(),
		['<C-k>'] = cmp.mapping.select_prev_item(),
		['<Tab>'] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources(unpack(sources)),
	sorting = {
		comparators = {
			function(...) return cmp_buffer:compare_locality(...) end,
		}
	},
	view = {
		entries = { name = 'custom', selection_order = 'near_cursor' }
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
			local strings = vim.split(kind.kind, "%s", { trimempty = true })
			kind.kind = " " .. (strings[1] or "") .. " "
			kind.menu = "    (" .. (strings[2] or "") .. ")"

			return kind
		end,
	},
})

-- git commit completions
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'buffer' },
	})
})

-- search completions
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- cmdline completions
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})

-- load vscode style snippets (from https://github.com/rafamadriz/friendly-snippets)
require("luasnip.loaders.from_vscode").lazy_load()
