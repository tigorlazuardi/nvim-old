local function setup()
	local custom_section = {
		a = {
			description = { '  Find File            ' },
			command = 'Telescope find_files',
		},
		b = {
			description = { '  Recently Opened Files' },
			command = 'Telescope oldfiles',
		},
		c = {
			description = { '  Recent Projects      ' },
			command = 'Telescope projects',
		},
		d = {
			description = { '  Load Session         ' },
			command = "lua require('session-lens').search_session()",
		},
		e = {
			description = { '  Find Word            ' },
			command = 'Telescope live_grep',
		},
		f = {
			description = { 'ﳟ  Change Theme         ' },
			command = "lua require('random-colors')()",
		},
	}

	local header = [[
                   -`
                  .o+`
                 `ooo/
                `+oooo:
               `+oooooo:
               -+oooooo+:
             `/:-:++oooo+:
            `/++++/+++++++:
           `/++++++++++++++:
          `/+++ooooooooooooo/`
         ./ooosssso++osssssso+`
        .oossssso-````/ossssss+`
       -osssssso.      :ssssssso.
      :osssssss/        osssso+++.
     /ossssssss/        +ssssooo/-
   `/ossssso+/:-        -:/+osssso+-
  `+sso+:-`                 `.-/+oso:
 `++:.                           `-/+/
 .`                                 `/
]]

	local processed_header = {}

	for str in header:gmatch('[^\r\n]+') do
		table.insert(processed_header, str)
	end
	vim.g.dashboard_default_executive = 'telescope'
	vim.g.dashboard_custom_section = custom_section
	vim.g.dashboard_custom_header = processed_header

	local footer = [[
     _              _     ____           ___  _
    | | _   _  ___ | |_  |  _ \   ___   |_ _|| |_
 _  | || | | |/ __|| __| | | | | / _ \   | | | __|
| |_| || |_| |\__ \| |_  | |_| || (_) |  | | | |_
 \___/  \__,_||___/ \__| |____/  \___/  |___| \__|
]]
	local processed_footer = {}

	for str in footer:gmatch('[^\r\n]+') do
		table.insert(processed_footer, str)
	end
	vim.g.dashboard_custom_footer = processed_footer
end

return function(use)
	use({ 'glepnir/dashboard-nvim', setup = setup })
end
