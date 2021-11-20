---protected require call
---@param m string
---@return any module the module itself. nil if not found.
return function(m)
	local _, err = pcall(require, m)
	return err
end
