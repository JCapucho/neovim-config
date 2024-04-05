if IsModuleEnabled("treesitter") then
	vim.treesitter.language.register('asm', 'mips')
end

return {}
