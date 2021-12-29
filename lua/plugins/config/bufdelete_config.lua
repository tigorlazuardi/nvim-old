return function(use)
	use({
		'famiu/bufdelete.nvim',
		config = function()
			require('which-key').register({
				['<leader>b'] = {
					name = '+buffer',
					D = {
						function()
							require('bufdelete').bufdelete(0, true)
						end,
						'Delete Current Buffer (Forced)',
					},
					d = {
						function()
							require('bufdelete').bufwipeout(0)
						end,
						'Delete Current Buffer',
					},
				},
			})
		end,
	})
end
