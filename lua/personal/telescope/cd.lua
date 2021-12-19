return function()
	local pickers = require('telescope.pickers')
	local finders = require('telescope.finders')
	local conf = require('telescope.config').values
	local state = require('telescope.actions.state')
	local actions = require('telescope.actions')

	pickers.new({}, {
		prompt_title = 'CD Dir',
		finder = finders.new_oneshot_job({ 'fd', '-t', 'd', '-H' }, {
			cwd = vim.fn.getcwd(),
		}),
		sorter = conf.generic_sorter({}),
		previewer = conf.file_previewer({}),
		attach_mappings = function(prompt_bufnr, _map)
			actions.select_default:replace(function()
				local selected = state.get_selected_entry(prompt_bufnr)
				actions.close(prompt_bufnr)
				if selected == nil then
					return
				end
				local result = vim.fn.chdir(selected.value)
				if result == '' then
					error('failed to cd to ' .. selected.value, vim.diagnostic.severity.E)
				end
			end)
			return true
		end,
	}):find()
end
