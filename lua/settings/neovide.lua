vim.g.neovide_remember_window_size = true
vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_cursor_vfx_mode = 'wireframe'
vim.g.neovide_floating_blur = 1
vim.g.neovide_window_floating_opacity = 1

local font_name = [[JetBrainsMono\ Nerd\ Font\ Mono]]
local font_size = 14
vim.cmd(string.format('set guifont=%s:h%d', font_name, font_size))

---set font size
---@param increase boolean
local function set_font_size(increase)
	if increase then
		font_size = font_size + 1
	else
		font_size = font_size - 1
	end
	local cmd = string.format('set guifont=%s:h%d', font_name, font_size)
	vim.cmd(cmd)
end

vim.keymap.set('n', 'g-', function()
	set_font_size(true)
end, { silent = true })
vim.keymap.set('n', 'g=', function()
	set_font_size(false)
end, { silent = true })
