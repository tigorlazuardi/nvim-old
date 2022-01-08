return function(use)
	use({
		'goolord/alpha-nvim',
		config = function()
			local alpha = require('alpha')
			local dashboard = require('alpha.themes.dashboard')
			dashboard.section.header.val = {
				[[           .o ,K ,O  '          ]],
				[[         MxKMMMMMMMNMW.o,       ]],
				[[      lMWMM0o:XMMX:o0MMMdlo     ]],
				[[    oMMMX,    cMMl    ,KMMd;'   ]],
				[[  .0KMMMk.    kMMO.   .xMMMM.   ]],
				[[  ,kMMXMMMMONMKxx0MWOMMMMXMMMx  ]],
				[[  cMMx  .lMM0      OMMl.  dMMx; ]],
				[[ :XMM:    NM.       MW    ;MM:  ]],
				[[  :MMx  .lMMO      OMMl.  dMMk; ]],
				[[  ;kMMXMMMMOWM0xx0MWOMMMMXMMMd  ]],
				[[  .KKMMMk.   .kMMO.   .xMMMM.   ]],
				[[    oMMMX,    cMMl    'KMMd;,   ]],
				[[      lMMMM0l:KMMX:lOMMMxlo     ]],
				[[         MkKMMMMMMMNMW.d,       ]],
				[[           .o ;K ;O  '          ]],
			}
			dashboard.section.buttons.val = {
				dashboard.button('e', '  New Empty Buffer', ':ene <BAR> startinsert <CR>'),
				dashboard.button('f', '  Find File', ':Telescope find_files<cr>'),
				dashboard.button('g', '  Find Word', ':Telescope live_grep<cr>'),
				dashboard.button('c', '  Change Directory', ':lua require("personal.telescope.cd")()<cr>'),
				dashboard.button('o', '  Recently Opened Files', ':Telescope oldfiles<cr>'),
				dashboard.button('p', '  Recent Projects', ':Telescope projects<cr>'),
				dashboard.button('s', '  Load Session', ':Telescope sessions<cr>'),
				dashboard.button('S', '  Load Last Session', ':LoadLastSession<cr>'),
				dashboard.button('d', '  Load Dir Session', ':LoadCurrentDirSession<cr>'),
				dashboard.button('q', '  Quit NVIM', ':qa<CR>'),
			}
			if vim.fn.exepath('fortune') ~= 0 then
				local handle = io.popen('fortune')
				local fortune = handle:read('*a')
				handle:close()
				dashboard.section.footer.val = fortune
			end
			dashboard.opts.opts.noautocmd = true
			alpha.setup(dashboard.opts)
		end,
	})
end
