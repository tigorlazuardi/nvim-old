local packer = require('plugins.bootstrap')

return packer.startup(function(use)
	use({ 'wbthomason/packer.nvim' })
	use({ 'nvim-lua/plenary.nvim' })
	use({ 'nvim-lua/popup.nvim' })
	require('plugins.config.alpha_config')(use)
	require('plugins.config.clipboard')(use)
	require('plugins.config.debugger')(use)
	require('plugins.config.indentation')(use)
	require('plugins.config.lsp')(use)
	require('plugins.config.lualine_config')(use)
	require('plugins.config.null_ls_config')(use)
	-- require('plugins.config.windline_config')(use)

	require('plugins.config.bufdelete_config')(use)
	require('plugins.config.bufferline_config')(use)
	-- require('plugins.config.chadtree_config')(use)
	require('plugins.config.comment_nvim')(use)
	-- require('plugins.config.coq_config')(use)
	require('plugins.config.discord')(use)
	require('plugins.config.dressing_config')(use)
	require('plugins.config.easy_align')(use)
	require('plugins.config.flutter')(use)
	require('plugins.config.focus_config')(use)
	require('plugins.config.git')(use)
	require('plugins.config.glow')(use)
	require('plugins.config.godot_integration')(use)
	require('plugins.config.golang_enhancement')(use)
	require('plugins.config.lazygit')(use)
	require('plugins.config.markdown_preview')(use)
	require('plugins.config.mini_config')(use)
	require('plugins.config.notify')(use)
	require('plugins.config.nvim_cmp')(use)
	require('plugins.config.nvim_gomove')(use)
	require('plugins.config.nvim_tree')(use)
	require('plugins.config.pounce_config')(use)
	require('plugins.config.pretty_fold')(use)
	require('plugins.config.scrollbar_config')(use)
	require('plugins.config.smart_pairs')(use)
	require('plugins.config.spectre_config')(use)
	require('plugins.config.sandwich')(use)
	require('plugins.config.tabout_config')(use)
	require('plugins.config.telescope_config')(use)
	require('plugins.config.textobjects')(use)
	require('plugins.config.theme')(use)
	require('plugins.config.tmux_config')(use)
	require('plugins.config.todo_comments')(use)
	require('plugins.config.toggleterm_config')(use)
	require('plugins.config.treesitter')(use)
	require('plugins.config.trouble_config')(use)
	require('plugins.config.vim_sneak')(use)
	require('plugins.config.which_key')(use)
	local compiled_file_path = vim.fn.stdpath('config') .. '/plugin/packer_compiled.lua'

	if vim.fn.filereadable(compiled_file_path) == 0 then
		packer.sync()
	end
end)
