return function(use)
	use({
		'ZhiyuanLck/smart-pairs',
		event = 'InsertEnter',
		config = function()
			require('pairs'):setup()
		end,
	})
end
