return function(cb)
	if vim.fn.foldclosed('.') ~= -1 then
		require('pretty-fold.preview').show_preview()
		return
	end
	cb()
end
