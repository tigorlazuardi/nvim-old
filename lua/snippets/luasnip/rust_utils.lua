local M = {}

local ts_utils = require('nvim-treesitter.ts_utils')
local ts_locals = require('nvim-treesitter.locals')

---check if cursor is in function
---@return boolean
function M.is_in_function()
	local current_node = ts_utils.get_node_at_cursor()
	if not current_node then
		return false
	end
	local expr = current_node

	while expr do
		if expr:type() == 'function_item' then
			return true
		end
		expr = expr:parent()
	end
	return false
end

return M
