-- Function to ensure packer is installed
-- returns wether packer was already present or not
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- Setup packer
local packer = require("packer")
packer.init({
	display = {
		open_fn = require('packer.util').float,
	}
})

-- Add essential packages
packer.use({ 'wbthomason/packer.nvim' })
packer.use({ 'nvim-lua/plenary.nvim' })

-- Load modules
NewConfig = function(enabledModules)
	local modules_set = {}
	for _, name in ipairs(enabledModules) do modules_set[name] = true end
	return modules_set
end

local modules = require('user.modules')

IsModuleEnabled = function(module) return modules[module] end

for name, _ in pairs(modules) do
	require(string.format('modules.%s', name))
end

-- If packer wasn't installed make sure to sync the dependencies
if packer_bootstrap then
	require('packer').sync()
end

-- Setup the reload config command
function _G.ReloadConfig()
	local reloader = require("plenary.reload")

	packer.reset()

	reloader.reload_module('user')
	reloader.reload_module('modules')

	dofile(vim.env.MYVIMRC)
	require('packer').sync()
end

vim.cmd('command! ReloadConfig lua ReloadConfig()')
