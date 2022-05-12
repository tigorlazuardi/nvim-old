-- local c = vim.api.nvim_command

---comment
---@param command_args any string or table of string
local function set(command_args)
	if type(command_args) == 'string' then
		command_args = { command_args }
	end
	vim.api.nvim_cmd({
		cmd = 'set',
		args = command_args,
	}, {})
end

set('cmdheight=2')
set('updatetime=50')
set('signcolumn=yes:1')
set('hidden')
set('splitright')
set('splitbelow')

set('foldnestmax=1')
set('scrolloff=8')
