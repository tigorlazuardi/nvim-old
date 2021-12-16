<a name="unreleased"></a>
## [Unreleased]

### Chore
- format

### Conf
- **bootstrap:** packer reset called before packer init to support reloading config
- **golang:** enabled dap config on golang files
- **neovide:** neovide config blur is removed since they fixed the blur problem on telescope
- **nvim_tree:** filtered node_modules and target for ts and rust respectively
- **prepare.sh:** added prepare.sh
- **project.nvim:** reenabled project nvim
- **settings:** font settings now check for wsl

### Feat
- **bufdelete:** support for bufdelete
- **comment.nvim:** removed kommentary in favor of comment.nvim
- **dressing.nvim:** added dressing.nvim plugin
- **null-ls:** added integration to curl and proselint
- **telescope:** added custom picker to cwd to given folder

### Fix
- **code-action:** removed code-action-menu because it does not get updated to neovim nightly
- **settings:** fix wsl check not checking the integer value
- **settings:** fix logic for wsl font in neovide
- **telescope:** fix cd picker
- **trouble.nvim:** fix trouble.nvim toggle update

### Refactor
- **settings:** more readable neovide config


<a name="v2.0.3"></a>
## [v2.0.3] - 2021-12-13
### Chore
- format

### Conf
- **autogroups:** removed augroup from buffer scoped autocmds
- **neovide:** set neovide transparency to 1
- **null_ls:** update configuration for null_ls
- **nvim-tree:** nvim tree highlight set to 3
- **whichkey:** pressing q and do nothing now shows the subkeylist for it

### Config
- **textobjects:** textobject is now loaded by vim-texobj-user
- **trouble:** trouble now calls the function directly instead of via command

### Docs
- update readme.md

### Feat
- **clang-format:** removed extra args in favor of .clang-format instead
- **clang-format:** added clang-format to null_ls
- **commitlint:** commitlint changed from nodejs to pure bash
- **lsp-lua:** added lsp lua config for windows
- **neovim:** all plugins are lazyloaded
- **settings:** now show enter chars
- **settings:** enabled set title so neovide can show different filesnames
- **taplo-lsp:** added lsp support for taplo
- **titlestring:** title string changed to cwd upon VimEnter and DirChanged
- **titlestring:** changed from only getcwd to prefixed with `nvim -`

### Fix
- **bug-empty-file:** fixed bug empty file on open
- **neoclip:** changed neoclip open to ge from <c-r>
- **rust_lsp:** proper path handling on require
- **tailwind-lsp:** autostart set back to true but depends on filetypes
- **vscode-compability:** packerload moved to packer.loader


<a name="v1.3.1"></a>
## [v1.3.1] - 2021-11-30
### Config
- **tailwind-lsp:** disabled autostart
- **vim-sneak:** mappings now extended to visual and selection mode
- **which-key:** disabled registers plugin for compability with tversteeg/registers

### Fix
- **selene:** packer plugins global variable is now proper

### Remove
- **textsubjects:** changed in favor of builtin selection


<a name="v1.3.0"></a>
## [v1.3.0] - 2021-11-29
### Doc
- **vim-sneak:** added which key alias to jump forward repeat sneak

### Feat
- **symbols-outline:** added symbols outline support

### Fix
- **vim-sneak:** load after vim-cutlass so vim-sneak overrides cutlass


<a name="v1.2.0"></a>
## [v1.2.0] - 2021-11-29
### Config
- **lspconfig:** added support for json and yaml language server
- **neovide:** added font size change implementation for UNIX system
- **neovide:** added firacode nerd font support on start
- **nvim-cmp:** now uses dark vscode theme
- **nvim-cmp:** added colorscheme to various item highlight in autocomplete
- **nvim_tree:** update nvim tree configuration
- **surround:** changed prefix to q instead of ss

### Feat
- **eslint_server:** added support for eslint_d lang server
- **fine-cmdline:** added new plugin fine-cmdline
- **lightspeed:** added lightspeed plugin
- **neovide:** added keymaps to increase or decrease font size in neovide
- **vim_sneak:** removed lightspeed, replaced with vim sneak

### Fix
- **jsonls:** fix command not found
- **nvim_tree:** disabled diagnostics on nvim-tree because it broke

### Remove
- **package-info:** removed package info causing crashes

### Revert
- **fine_cmdline:** cmdline broke too much and broke compability with vscode


<a name="v1.1.0"></a>
## [v1.1.0] - 2021-11-21
### Chore
- format lua files

### Conf
- **lefthook:** reword pipe names

### Config
- **godot:** added global option to disable godot lsp if godot is installed but don't plan to use neovim for coding
- **headwind:** surpressed headwind error message on sorting
- **neovide:** disable blur for multigrid mode
- **null-ls:** mappings now always possible whenever null_ls is loaded
- **null_ls:** enabled autostart
- **package-info:** package info now is limited to filetype json
- **settings:** added linebreak by words not character settings

### Doc
- change changelog template

### Feat
- **codeactionmenu:** added new plugin code action menu
- **tailwind-headwind:** added tailwind and headwind support

### Fix
- **lefthook:** removed double changelog running
- **lsp_status:** fix lsp status on airline not showing messages
- **package_info:** fix package_info yelling error on recompiling
- **selene:** fix vim global not set
- **telescope:** now fzf and frecency is loaded properly after telescope
- **treesitter:** fix plugins failed to load

### Mappings
- **diagnostic:** gn now shows line diagnostic, gN show workspace. gnn show next. gnp show previous
- **gitsigns:** added mappings to controls hunks
- **lsp:** added mappings for lsp formatting
- **packer:** added packer command mappings

### WIP
- **buffer-mapping:** bootstrapped buffer mapping

### Wip
- **calltree:** bootstrapped calltree

### Reverts
- conf(lefthook): reword pipe names


<a name="v1.0.4"></a>
## [v1.0.4] - 2021-11-15
### Chore
- format

### Config
- **focus.nvim:** sign column now won't disappear on not focused windows
- **yoink:** added configuration

### Feat
- **clipboard:** reenable cutlass, registers and subversibe, but removed yoink
- **focus.nvim:** added focus nvim
- **lsp:** added godot lsp setting
- **lspconfig:** added support for godot and tailwindcss
- **neoclip:** moved clipboard management to neoclip
- **neoclip:** moved clipboard management to neoclip
- **treesitter:** treesitter now not running on vscode
- **vscode:** mappings for vscode
- **windline:** added lsp status integration to airline
- **windline:** moved from sample to local airline config

### Fix
- **lsp:** fix lsp status not initialized, and typescript lsp config not called
- **packer-init-nvim:** clone timeout raised from 600 to 3000
- **windows:** more compability codes
- **windows:** disabled some plugins and settings that are incompatible in windows

### Linter
- **golangci:** disabled auto fix for compability reason

### Refactor
- **globals:** changed from using _G to vim.g

### Settings
- added backup settings
- added nvr integration
- added noswapfile noundofile
- no backup files in writing files

### Reverts
- feat(lsp): added godot lsp setting


<a name="v1.0.1"></a>
## [v1.0.1] - 2021-11-03
### Doc
- added changelog.md file

### Fix
- **paths:** fix potential duplicate require


<a name="v1.0.0"></a>
## v1.0.0 - 2021-11-03
### Doc
- added changelog template

### Init
- initial commit

### Refactor
- **indentation:** moved indentation to it's own folder


[Unreleased]: https://github.com/tigorlazuardi/nvim/compare/v2.0.3...HEAD
[v2.0.3]: https://github.com/tigorlazuardi/nvim/compare/v1.3.1...v2.0.3
[v1.3.1]: https://github.com/tigorlazuardi/nvim/compare/v1.3.0...v1.3.1
[v1.3.0]: https://github.com/tigorlazuardi/nvim/compare/v1.2.0...v1.3.0
[v1.2.0]: https://github.com/tigorlazuardi/nvim/compare/v1.1.0...v1.2.0
[v1.1.0]: https://github.com/tigorlazuardi/nvim/compare/v1.0.4...v1.1.0
[v1.0.4]: https://github.com/tigorlazuardi/nvim/compare/v1.0.1...v1.0.4
[v1.0.1]: https://github.com/tigorlazuardi/nvim/compare/v1.0.0...v1.0.1
