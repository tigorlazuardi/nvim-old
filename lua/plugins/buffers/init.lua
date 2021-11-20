_G.buffer_filetype_mapping = function()
	local function prequire(m)
		local ok, err = pcall(require, m)
		if not ok then
			return nil, err
		end
		return err
	end
	local wk = prequire('which-key')

	if not wk then
		return
	end

	---checks if filetype matches current buffer
	---@param filetype string
	---@return boolean
	local function is(filetype)
		return vim.bo.filetype == filetype
	end
end

vim.cmd([[
	augroup set_buffer_mappings
		au!
		au BufNewFile,BufRead * v:lua.buffer_filetype_mapping()
	augroup end
]])
