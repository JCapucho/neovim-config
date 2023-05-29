require('dashboard').setup({
	theme = "hyper",
	config = {
		shortcut = {
			{
				icon = '󰚰 ',
				icon_hl = '@variable',
				desc = 'Update',
				group = '@property',
				action = 'PackerSync',
				key = 'u'
			},
			{
				icon = ' ',
				icon_hl = '@variable',
				desc = 'Files',
				group = 'Label',
				action = 'Telescope find_files',
				key = 'f',
			},
		},
		project = {
			enable = true,
			limit = 8,
			icon = '󰏓 ',
			label = 'Recent Projects',
			action = 'Telescope find_files cwd='
		},
		mru = { limit = 10, icon = '󰋚 ', label = 'Most Recent Files' },
	},
})
