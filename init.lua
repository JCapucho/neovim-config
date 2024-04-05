-- Function to ensure lazy is installed
-- returns wether lazy was already present or not
local ensure_lazy = function()
	local fn = vim.fn

	local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
	local bootstrap = not (vim.uv or vim.loop).fs_stat(lazypath);

	if bootstrap then
		fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			lazypath,
		})
	end

	vim.opt.rtp:prepend(lazypath)
	return bootstrap
end

local lazy_bootstrap = ensure_lazy()

-- Always required modules
local modules = { "base" }
for _, v in ipairs(require('user.modules')) do
	table.insert(modules, v)
end

local lazy_specs = {}
local loaded_modules = {}

for _, name in ipairs(modules) do
	loaded_modules[name] = true
	local importspec = string.format('modules.%s.plugins', name);
	table.insert(lazy_specs, { import = importspec })
end

IsModuleEnabled = function(module) return loaded_modules[module] end

require("lazy").setup(lazy_specs)

-- If lazy wasn't installed make sure to sync the dependencies
if lazy_bootstrap then
	require('lazy').install()
end
