local M = {}

---splits string with given separator and use given function to iterate over the elements
---
---use `split` instead of this to return list of string instead.
---@param s string value to split
---@param sep string? separator to split with. if nil, will split on any white space.
---@param func fun(s: string) callback function to handle iterated element.
function M.splitf(s, sep, func)
	if sep == nil then
		sep = '%s'
	end

	for str in s:gmatch('([^' .. sep .. ']+)') do
		func(str)
	end
end

---splits string with given separator. If sep is nil, will split on empty whitespace.
---@param s string
---@param sep string?
---@return string[]
function M.split(s, sep)
	local result = {}

	M.splitf(s, sep, function(str)
		table.insert(result, str)
	end)

	return result
end

return M
