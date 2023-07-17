local cache_dir = vim.fs.normalize(vim.env.XDG_CACHE_HOME or "~/.cache")

local function tableMerge(t1, t2)
	for k, v in pairs(t2) do t1[k] = v end

	return t1
end

local function strIsEmpty(s)
	return s == nil or s == ''
end

local function findExecutable(execs)
	for _, exec in ipairs(execs) do
		local cmd = vim.fn.exepath(exec)
		if not strIsEmpty(cmd) then
			return cmd
		end
	end

	return execs[0]
end

return {
	cache_dir = cache_dir,
	tableMerge = tableMerge,
	strIsEmpty = strIsEmpty,
	findExecutable = findExecutable,
}
