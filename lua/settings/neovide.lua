vim.g.neovide_remember_window_size = true
vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_cursor_vfx_mode = 'wireframe'
vim.g.neovide_floating_blur = 1
vim.g.neovide_window_floating_opacity = 1

local font_name = [[JetBrainsMono\ Nerd\ Font\ Mono]]
local font_size = 14

---set font size
---@param font_name string
---@param size integer
local function set_font_size(size)
	local cmd = string.format('set guifont=%s:h%d', font_name, size)
	vim.cmd(cmd)
end

set_font_size(font_size)
vim.keymap.set('n', 'g-', function()
	font_size = font_size - 1
	set_font_size(font_size)
end, { silent = true })
vim.keymap.set('n', 'g=', function()
	font_size = font_size + 1
	set_font_size(font_size)
end, { silent = true })
