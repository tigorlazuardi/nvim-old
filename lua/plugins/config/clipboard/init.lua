return function(use)
	require('plugins.config.clipboard.cutlass_config')(use)
	require('plugins.config.clipboard.registers')(use)
	require('plugins.config.clipboard.substitute_config')(use)
end
