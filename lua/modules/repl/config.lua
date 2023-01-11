if IsModuleEnabled('treesitter') then
	vim.g['conjure#client_on_load'] = false
	vim.g['conjure#extract#tree_sitter#enabled'] = true
end
