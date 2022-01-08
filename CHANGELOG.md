<a name="unreleased"></a>
## [Unreleased]

### Feat
- **coq:** <c-h> now does not escape to normal mode first
- **pretty-fold:** set fold next max to 1
- **pretty-fold:** added pretty fold
- **settings:** H now moved to close fold, L to open fold
- **telescope:** added telescope env
- **treesitter:** foldexprt now to treesitter

### Fix
- **tabout:** fix whichkey missing '>'


<a name="v3.0.3"></a>
## [v3.0.3] - 2022-01-08
### Feat
- **alpha:** fortune now only get if exist
- **alpha:** added Change Directory entry
- **alpha:** moved from dashboard to alpha
- **nvim-tree:** auto open on startup


<a name="v3.0.2"></a>
## [v3.0.2] - 2022-01-07
### Feat
- moved to coq and chadtree
- update config for nvim-tree
- added session manager
- lsp diagnostic now is float based on scope cursor
- update
- set default color to catpuccin
- nvim_gomove instead of vim_move
- removed plenary from lazygit plugin
- changed lazygit to direct integration
- **airline:** removed file icon in explorer tree in bottom right
- **airline:** added support to show the tree plugin name
- **nvim-tree:** nvim tree width size now 40
- **nvim-tree:** added `.git` to ignore list

### Fix
- **which-key:** removed conflicting mappings with which-key
- **which-key:** temporarily changed to zeertzjq fork To support latest neovim branch

### Revert
- removed nvim-treesitter-context in favor of session manager
- removed theme change on DirChanged
- return to nvim tree because chadtree theme is ugly


<a name="v3.0.1"></a>
## [v3.0.1] - 2022-01-01
### Feat
- **debugger:** now uses personal one with wrap set to default on
- **flutter:** added more keybindings
- **flutter:** added flutter

### Fix
- **flutter:** run via dap disabled
- **flutter:** fix list commands
- **theme:** theme now fixed

### Refactor
- **golang-lsp:** staticcheck now depends on golangci lint


<a name="v3.0.0"></a>
## [v3.0.0] - 2021-12-29
### Chore
- **golang-ls:** removed unused codes

### Feat
- **all:** moved to a new beginning
- **debugger:** change mapping and local
- **theme:** random theme now won't repeat last
- **theme:** add more themes
- **theme:** added tokyonight

### Fix
- **dlv:** command returned from dlv-dap to dlv


<a name="v2.6.0"></a>
## [v2.6.0] - 2021-12-28
### Conf
- **focus:** excluded filetypes now includes dapui
- **neovide:** update neovide setting

### Feat
- **dap:** dap dlv now listens on both stdout and stderr
- **dap:** load vs code config now appends dlvToolPath
- **debugger:** added dapui open on success booting dap
- **golang:** commented null_ls goimports gofumpt golines
- **golang:** null_ls added golines
- **golang:** reenabled goimports
- **lsp-server:** schemas now using schemastore
- **lspsaga:** added lspsaga
- **telescope:** include oldfiles in code
- **vim_move:** added vim move

### Fix
- **commitlint:** skip on pull
- **lsp:** Stopping hotkey now stops ALL lsp server instead of only one
- **neovide:** opacity
- **null_ls:** removed generic on attach from null_ls
- **on_attach:** open float diagnostic is now line wise
- **project:** fix project loader
- **theme:** disabled catpuccin and sonokai on windows
- **theme:** fix theme
- **treesitter:** textobjects and various treesitter plugins now loaded manually using packer loader

### Refactor
- **nvim-cmp:** <cr> now does not select selection
- **nvim-goc:** change mapping group to <leader>g

### Revert
- return back to nvim_cmp because coq crashes too often
- **lsp:** return back to dressing and disabled lsp saga
- **lspsaga:** removed lsp saga


<a name="v2.4.0"></a>
## [v2.4.0] - 2021-12-19
### Feat
- **golang:** moved from context organize imports to goimports in null ls
- **null_ls:** added sqlformat and codespell diagnostics

### Refactor
- **golang:** format and generate implementations moved to <leader>g group
- **lazygit:** moved mapkey from <leader>g to <leader>z


<a name="v2.3.1"></a>
## [v2.3.1] - 2021-12-19
### Chore
- formatting
- comment codes for documentation

### Feat
- **theme:** added sonokai to the list

### Fix
- **goimpl:** added buffer target of current
- **goimpl:** mapping is now localized to buffer filetype go
- **lsp:** formatting now done on BufWritePre not on BufWritePost and scoped to current buffer
- **on_attach:** fix diagnostic and telescope diagnostic

### Refactor
- **goimpl:** moved autocmd to on-attach
- **on_attach:** moved gn diagnostic mapping to a new sub whichkey group
- **telescope-cd:** moved telescope cd to a file for more readable

### Reverts
- refactor(on_attach): moved gn diagnostic mapping to a new sub whichkey group


<a name="v2.3.0"></a>
## [v2.3.0] - 2021-12-18
### Feat
- **theme:** removed themes containing light colors so random colors wont load the white ones


<a name="v2.2.0"></a>
## [v2.2.0] - 2021-12-18
### Chore
- removed kommentary

### Feat
- **golang:** added go coverage and go impl telescope
- **theme:** added random color loader
- **treesitter-context:** added support for tree sitter context


<a name="v2.1.0"></a>
## [v2.1.0] - 2021-12-16
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
- **coq_nvim:** added coq_nvim
- **dressing.nvim:** added dressing.nvim plugin
- **lsp-display:** lsp display now shows borders
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


[Unreleased]: https://github.com/tigorlazuardi/nvim/compare/v3.0.3...HEAD
[v3.0.3]: https://github.com/tigorlazuardi/nvim/compare/v3.0.2...v3.0.3
[v3.0.2]: https://github.com/tigorlazuardi/nvim/compare/v3.0.1...v3.0.2
[v3.0.1]: https://github.com/tigorlazuardi/nvim/compare/v3.0.0...v3.0.1
[v3.0.0]: https://github.com/tigorlazuardi/nvim/compare/v2.6.0...v3.0.0
[v2.6.0]: https://github.com/tigorlazuardi/nvim/compare/v2.4.0...v2.6.0
[v2.4.0]: https://github.com/tigorlazuardi/nvim/compare/v2.3.1...v2.4.0
[v2.3.1]: https://github.com/tigorlazuardi/nvim/compare/v2.3.0...v2.3.1
[v2.3.0]: https://github.com/tigorlazuardi/nvim/compare/v2.2.0...v2.3.0
[v2.2.0]: https://github.com/tigorlazuardi/nvim/compare/v2.1.0...v2.2.0
[v2.1.0]: https://github.com/tigorlazuardi/nvim/compare/v2.0.3...v2.1.0
[v2.0.3]: https://github.com/tigorlazuardi/nvim/compare/v1.3.1...v2.0.3
[v1.3.1]: https://github.com/tigorlazuardi/nvim/compare/v1.3.0...v1.3.1
[v1.3.0]: https://github.com/tigorlazuardi/nvim/compare/v1.2.0...v1.3.0
[v1.2.0]: https://github.com/tigorlazuardi/nvim/compare/v1.1.0...v1.2.0
[v1.1.0]: https://github.com/tigorlazuardi/nvim/compare/v1.0.4...v1.1.0
[v1.0.4]: https://github.com/tigorlazuardi/nvim/compare/v1.0.1...v1.0.4
[v1.0.1]: https://github.com/tigorlazuardi/nvim/compare/v1.0.0...v1.0.1
