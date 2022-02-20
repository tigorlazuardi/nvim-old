return function(args)
	local tags = {}
	for i, value in pairs(args) do
		if value:find('-tags') then
			table.insert(tags, value)
			table.remove(args, i)
			break
		end
	end
	return tags, args
end
