_G.buffer_filetype_mapping = function()
	local prequire = require('personal.utils.prequire')
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

	if is('Calltree') then
		require('plugins.buffers.calltree_buffer')()
	end
end

vim.cmd([[
	augroup set_buffer_mappings
		au!
		au BufNewFile,BufRead * call v:lua.buffer_filetype_mapping()
	augroup end
]])
