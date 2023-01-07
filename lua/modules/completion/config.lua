local cmp = require 'cmp'

local sources = {
	{
		{ name = 'nvim_lsp' },
	},
	{
		{ name = 'path' },
		{ name = 'buffer' },
	}
}

if IsModuleEnabled('lsp') then
	table.insert(sources[1], { name = 'nvim_lsp_signature_help' })
	table.insert(sources[1], { name = 'luasnip' })
end

cmp.setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<Tab>'] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources(unpack(sources))
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
