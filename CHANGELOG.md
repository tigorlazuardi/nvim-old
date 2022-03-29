<a name="unreleased"></a>
### [Unreleased]

> Bug Fixes
- **luasnip:** update configuration

> Documentation
- update readme.md for dependencies

> Features
- **luasnip:** enabled autosnippets
- **markdown-composer:** autostart disbled
- **markdown-composer:** added markdown composer

> Revert
- move back to nvim-autopairs
- global status


<a name="v3.1.5"></a>
### [v3.1.5] - 2022-03-18

> Bug Fixes
- **focus:** disabled temporarily until work nice with nvim-tree
- **golang:** test regex now include end $ sign
- **nvim-ts-rainbow:** froze to commit until problem is fixed

> Code Refactoring
- **debugger-go:** dryer code
- **init:** refactor settings/init.lua

> Documentation
- hide changelog into spoiler

> Features
- **dap-go:** added feature to restore original dap config
- **filetype:** added certain filetype auto detect
- **focus:** reenabled focus config
- **go:** test function now never cache
- **golang:** change mappings for nvim goc
- **golang:** added debug current function
- **golang:** set golines limit to 200
- **golang:** disabled golines and golangci-lint on nullls
- **lualine:** added global status setting
- **markdown-pp:** added markdown pp
- **marks:** update various marks file
- **nvim:** max_line_lne set to 150
- **nvim-tree:** update config
- **nvim-tree:** ignore notify window
- **sudo:** added suda plugin
- **windows:** enabled more compatibility

> Revert
- updating neovim fixed the issue


<a name="v3.1.4"></a>
### [v3.1.4] - 2022-02-24

> Bug Fixes
- **golang:** textobjects now false to ignore shitty error on start
- **golang:** ray-x/go.nvim now always runs and never depends on if gopls is installed first

> Documentation
- added reason to ignore textobject option from go.nvim

> Revert
- removed treesitter playground since it's mostly unused


<a name="v3.1.3"></a>
### [v3.1.3] - 2022-02-24

> Features
- **fidget:** moved to fidget nvim from lsp-status
- **golang:** added go test workspace
- **golang:** added go test package
- **golang:** call feedkeys moved to on_exit
- **golang:** uses custom terminal to run go test function
- **nvim-cmp:** added ripgrep source
- **nvim-tree:** removed frozen commit
- **yabs:** added yabs nvim

> Revert
- removed yabs
- move to smart-pairs again
- move back to nvim autopairs

> Various Actions
- removed coq and chadtree from nvim
- removed commented surruond_config in init
- removed surround config because dev is MIA
- removed old windline config


<a name="v3.1.2"></a>
### [v3.1.2] - 2022-02-16

> Bug Fixes
- **lsp-status:** now lsp status line does not check buf get clients
- **nvim-tree:** temporarily froze nvim tree version to latest stable commit
- **prettierd:** fix prettierd config for null_ls
- **tmux:** removed resize default keybinding because conflict with line swap

> Code Refactoring
- **golang:** removed unneeded configs
- **lsp:** better readability syntax
- **neovide:** refactor config
- **neovide:** refactor neovide configurations

> Features
- **cmp-lspkind:** update configuration
- **golang:** update enhancement configuration
- **golang:** added mappings for golang specifics
- **hlargs:** added
- **lsp:** fix cursor jumpt to diagnostic window on goto_next
- **lsp:** update lsp in insert mode disabled to increase peformance on slow lsps
- **lualine:** better color for modified
- **mini:** disabled on some filetypes
- **mini-indentscope:** added mini indentscope
- **notify:** added notify on installing sumneko lua server
- **notify:** added nvim-notify
- **null_ls:** revert to prettierd and eslint_d now only runs if eslintrc.json exist in root
- **pairs:** moved to smart pairs
- **sandwhich:** fix missing mappings
- **sandwhich:** moved from surround.nvim to vim-sandwhich because dev account is deleted
- **session_manager:** session manager now autoload currentdir
- **statusline:** revert to lualine from windline
- **tmux:** disabled copy_sync to sync clipboard with system clipboard instead of tmux
- **tmux:** added tmux config
- **treesitter:** added endwise

> Revert
- disabled pretty_fold in favor of tmux integration
- **nvim-tree:** disabled open on new
- **treesitter:** disabled indent and hlargs

> Various Actions
- format


<a name="v3.1.1"></a>
### [v3.1.1] - 2022-02-04

> Bug Fixes
- **lua-lsp:** lsp is fixed by settings server version to v2.5.6
- **sumneko_lua-installer:** version is now frozen to v2.5.6
- **treesitter:** removed themes that broke treesitter
- **treesitter:** temporary fix until treesitter stabilizes
- **treesitter-indent:** disabled on yaml files

> Code Refactoring
- **golang:** golang now uses ray-x/go command to format or import and removed formatters from null-ls
- **golang:** separated golang from top level config
- **json_yaml:** added to separate configuration
- **lsp:** refactor code for more readability
- **lsp:** uses accosiative table instead of numeric table to check available lsps
- **lua-lsp:** added to separate configuration
- **neovide:** refactor neovide font settings
- **packer:** packer now automatically sync if packer_compiled.lua file is missing

> Configuration
- **changelog:** added title mappings

> Documentation
- **neovide:** added params

> Features
- **eslint:** now moved to null_ls
- **flutter:** flutter lsp now only runs if dart is installed
- **fzf:** removed disabled requirement on windows
- **languages:** registered lua
- **lsp-installer:** now gopls waits for rayx go
- **lua-lsp:** path handling is now handled by plenary
- **neogen:** added neogen
- **nvim-tree:** added indent markers
- **packer:** removed from opt
- **prettier_d_slim:** try to use prettier_d_slim, falls back to prettierd
- **rust:** separated rust config to another file
- **rust:** added dap config
- **rust:** dap config on wsl
- **rust:** having rust opened now auto install rust-analyzer
- **rust-analyzer:** ignored on generic lsp installer config
- **theme:** added github theme
- **treesitter:** added rainbow brackets
- **treesitter:** change mappings for more intuitivemove
- **typescript:** config update

> Revert
- removed headwind in favor of rustywind via null_ls
- **treesitter:** disabled indent by treesitter

> Various Actions
- grammar fixes
- removed unused plugins from codebase
- merge
- removed useless block


<a name="v3.1.0"></a>
### [v3.1.0] - 2022-01-18

> Bug Fixes
- **eslint:** fix installer config not called
- **tabout:** fix whichkey missing '>'
- **vim-sneak:** S mapping is now uncommented
- **vim_sneak:** fixed load order to be after vim-cutlass

> Configuration
- **bootstrap:** changed max jobs to 16

> Features
- **alpha:** fortune only called if it exist
- **catppuccin:** load from setup now
- **coq:** <c-h> now does not escape to normal mode first
- **cutlass-substitute:** using modern alternative
- **dap:** added native widgets for debug hover
- **lsp:** added yamlls custom schemas
- **lsp:** disabled open float in favor of lsp_lines
- **lsp-insstall:** eslint
- **lsp_lines:** changed packer declaration using as
- **lsp_lines:** added lsp_lines
- **markdown-preview:** added markdown preview
- **neovim-dap:** added command to easily debug neovim itself
- **nvim-lspinstall:** migrated to nvim lsp install
- **pounce:** s key now uses pouce. the rest still uses vim sneak
- **pretty-fold:** added pretty fold
- **pretty-fold:** set fold next max to 1
- **scrollbar:** added scrollbar
- **session:** conform to breaking changes
- **settings:** added scroll off value of 8
- **settings:** H now moved to close fold, L to open fold
- **sumneko:** prevent using lua-dev temporarily until it get fixed
- **telescope:** added telescope env
- **treesitter:** foldexprt now to treesitter
- **types:** added types for lua
- **which-key:** shortcut to show mappings has changed from '?' to 'g?'
- **which-key:** added dofile on <leader>pR
- **which-key:** return back to folke's version
- **windline:** added lsp signature

> Revert
- diagnostic format returns to default
- **lsp_lines:** removed lsp_lsplines

> Various Actions
- grammar fixes
- cleanup ^M
- removed unused codes
- removed commented code
- removed useless code block


<a name="v3.0.3"></a>
### [v3.0.3] - 2022-01-08

> Features
- **alpha:** fortune now only get if exist
- **alpha:** added Change Directory entry
- **alpha:** moved from dashboard to alpha
- **nvim-tree:** auto open on startup


<a name="v3.0.2"></a>
### [v3.0.2] - 2022-01-07

> Bug Fixes
- **which-key:** removed conflicting mappings with which-key
- **which-key:** temporarily changed to zeertzjq fork To support latest neovim branch

> Features
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

> Revert
- removed nvim-treesitter-context in favor of session manager
- removed theme change on DirChanged
- return to nvim tree because chadtree theme is ugly


<a name="v3.0.1"></a>
### [v3.0.1] - 2022-01-01

> Bug Fixes
- **flutter:** run via dap disabled
- **flutter:** fix list commands
- **theme:** theme now fixed

> Code Refactoring
- **golang-lsp:** staticcheck now depends on golangci lint

> Features
- **debugger:** now uses personal one with wrap set to default on
- **flutter:** added more keybindings
- **flutter:** added flutter


<a name="v3.0.0"></a>
### [v3.0.0] - 2021-12-29

> Bug Fixes
- **dlv:** command returned from dlv-dap to dlv

> Features
- **all:** moved to a new beginning
- **debugger:** change mapping and local
- **theme:** random theme now won't repeat last
- **theme:** add more themes
- **theme:** added tokyonight

> Various Actions
- **golang-ls:** removed unused codes


<a name="v2.6.0"></a>
### [v2.6.0] - 2021-12-28

> Bug Fixes
- **commitlint:** skip on pull
- **neovide:** opacity
- **project:** fix project loader
- **theme:** fix theme
- **theme:** disabled catpuccin and sonokai on windows

> Configuration
- **focus:** excluded filetypes now includes dapui
- **neovide:** update neovide setting

> Features
- **dap:** dap dlv now listens on both stdout and stderr
- **dap:** load vs code config now appends dlvToolPath
- **debugger:** added dapui open on success booting dap
- **lsp-server:** schemas now using schemastore
- **telescope:** include oldfiles in code

> Revert
- **lsp:** return back to dressing and disabled lsp saga
- **lspsaga:** removed lsp saga


<a name="v2.5.0"></a>
### [v2.5.0] - 2021-12-25

> Bug Fixes
- **lsp:** Stopping hotkey now stops ALL lsp server instead of only one
- **null_ls:** removed generic on attach from null_ls

> Features
- **lspsaga:** added lspsaga


<a name="v2.4.1"></a>
### [v2.4.1] - 2021-12-22

> Bug Fixes
- **on_attach:** open float diagnostic is now line wise
- **treesitter:** textobjects and various treesitter plugins now loaded manually using packer loader

> Code Refactoring
- **nvim-cmp:** <cr> now does not select selection
- **nvim-goc:** change mapping group to <leader>g

> Features
- **golang:** reenabled goimports
- **golang:** commented null_ls goimports gofumpt golines
- **golang:** null_ls added golines
- **vim_move:** added vim move

> Revert
- return back to nvim_cmp because coq crashes too often


<a name="v2.4.0"></a>
### [v2.4.0] - 2021-12-19

> Code Refactoring
- **golang:** format and generate implementations moved to <leader>g group
- **lazygit:** moved mapkey from <leader>g to <leader>z

> Features
- **golang:** moved from context organize imports to goimports in null ls
- **null_ls:** added sqlformat and codespell diagnostics


<a name="v2.3.1"></a>
### [v2.3.1] - 2021-12-19

> Bug Fixes
- **goimpl:** added buffer target of current
- **goimpl:** mapping is now localized to buffer filetype go
- **lsp:** formatting now done on BufWritePre not on BufWritePost and scoped to current buffer
- **on_attach:** fix diagnostic and telescope diagnostic

> Code Refactoring
- **goimpl:** moved autocmd to on-attach
- **on_attach:** moved gn diagnostic mapping to a new sub whichkey group
- **telescope-cd:** moved telescope cd to a file for more readable

> Features
- **theme:** added sonokai to the list

> Various Actions
- formatting
- comment codes for documentation

> Reverts
- refactor(on_attach): moved gn diagnostic mapping to a new sub whichkey group


<a name="v2.3.0"></a>
### [v2.3.0] - 2021-12-18

> Features
- **theme:** removed themes containing light colors so random colors wont load the white ones


<a name="v2.2.0"></a>
### [v2.2.0] - 2021-12-18

> Bug Fixes
- **code-action:** removed code-action-menu because it does not get updated to neovim nightly
- **settings:** fix wsl check not checking the integer value
- **settings:** fix logic for wsl font in neovide
- **telescope:** fix cd picker
- **trouble.nvim:** fix trouble.nvim toggle update

> Code Refactoring
- **settings:** more readable neovide config

> Configuration
- **bootstrap:** packer reset called before packer init to support reloading config
- **golang:** enabled dap config on golang files
- **neovide:** neovide config blur is removed since they fixed the blur problem on telescope
- **nvim_tree:** filtered node_modules and target for ts and rust respectively
- **prepare.sh:** added prepare.sh
- **project.nvim:** reenabled project nvim
- **settings:** font settings now check for wsl

> Features
- **bufdelete:** support for bufdelete
- **comment.nvim:** removed kommentary in favor of comment.nvim
- **coq_nvim:** added coq_nvim
- **dressing.nvim:** added dressing.nvim plugin
- **golang:** added go coverage and go impl telescope
- **lsp-display:** lsp display now shows borders
- **null-ls:** added integration to curl and proselint
- **telescope:** added custom picker to cwd to given folder
- **theme:** added random color loader
- **treesitter-context:** added support for tree sitter context

> Various Actions
- removed kommentary
- format


<a name="v2.0.3"></a>
### [v2.0.3] - 2021-12-13

> Configuration
- **autogroups:** removed augroup from buffer scoped autocmds
- **neovide:** set neovide transparency to 1
- **null_ls:** update configuration for null_ls
- **whichkey:** pressing q and do nothing now shows the subkeylist for it

> Documentation
- update readme.md

> Features
- **clang-format:** removed extra args in favor of .clang-format instead
- **settings:** now show enter chars


<a name="v2.1.0"></a>
### [v2.1.0] - 2021-12-08

> Features
- **clang-format:** added clang-format to null_ls
- **titlestring:** changed from only getcwd to prefixed with `nvim -`

> Various Actions
- format


<a name="v2.0.2"></a>
### [v2.0.2] - 2021-12-08

> Config
- **textobjects:** textobject is now loaded by vim-texobj-user
- **trouble:** trouble now calls the function directly instead of via command

> Configuration
- **nvim-tree:** nvim tree highlight set to 3

> Features
- **commitlint:** commitlint changed from nodejs to pure bash
- **settings:** enabled set title so neovide can show different filesnames
- **titlestring:** title string changed to cwd upon VimEnter and DirChanged


<a name="v2.0.1"></a>
### [v2.0.1] - 2021-12-05

> Bug Fixes
- **bug-empty-file:** fixed bug empty file on open
- **vscode-compability:** packerload moved to packer.loader


<a name="v2.0.0"></a>
### [v2.0.0] - 2021-12-05

> Bug Fixes
- **neoclip:** changed neoclip open to ge from <c-r>
- **rust_lsp:** proper path handling on require
- **tailwind-lsp:** autostart set back to true but depends on filetypes

> Features
- **lsp-lua:** added lsp lua config for windows
- **neovim:** all plugins are lazyloaded
- **taplo-lsp:** added lsp support for taplo


<a name="v1.3.1"></a>
### [v1.3.1] - 2021-11-30

> Bug Fixes
- **selene:** packer plugins global variable is now proper

> Config
- **tailwind-lsp:** disabled autostart
- **vim-sneak:** mappings now extended to visual and selection mode
- **which-key:** disabled registers plugin for compability with tversteeg/registers

> Remove
- **textsubjects:** changed in favor of builtin selection


<a name="v1.3.0"></a>
### [v1.3.0] - 2021-11-29

> Bug Fixes
- **vim-sneak:** load after vim-cutlass so vim-sneak overrides cutlass

> Doc
- **vim-sneak:** added which key alias to jump forward repeat sneak

> Features
- **symbols-outline:** added symbols outline support


<a name="v1.2.0"></a>
### [v1.2.0] - 2021-11-29

> Bug Fixes
- **jsonls:** fix command not found
- **nvim_tree:** disabled diagnostics on nvim-tree because it broke

> Config
- **lspconfig:** added support for json and yaml language server
- **neovide:** added font size change implementation for UNIX system
- **neovide:** added firacode nerd font support on start
- **nvim-cmp:** now uses dark vscode theme
- **nvim-cmp:** added colorscheme to various item highlight in autocomplete
- **nvim_tree:** update nvim tree configuration
- **surround:** changed prefix to q instead of ss

> Features
- **eslint_server:** added support for eslint_d lang server
- **fine-cmdline:** added new plugin fine-cmdline
- **lightspeed:** added lightspeed plugin
- **neovide:** added keymaps to increase or decrease font size in neovide
- **vim_sneak:** removed lightspeed, replaced with vim sneak

> Remove
- **package-info:** removed package info causing crashes

> Revert
- **fine_cmdline:** cmdline broke too much and broke compability with vscode


<a name="v1.1.0"></a>
### [v1.1.0] - 2021-11-21

> Bug Fixes
- **lefthook:** removed double changelog running

> Config
- **null_ls:** enabled autostart

> Configuration
- **lefthook:** reword pipe names

> Doc
- change changelog template

> Mappings
- **diagnostic:** gn now shows line diagnostic, gN show workspace. gnn show next. gnp show previous

> Various Actions
- format lua files

> WIP
- **buffer-mapping:** bootstrapped buffer mapping

> Wip
- **calltree:** bootstrapped calltree

> Reverts
- conf(lefthook): reword pipe names


<a name="v1.0.9"></a>
### [v1.0.9] - 2021-11-16

> Bug Fixes
- **selene:** fix vim global not set

> Config
- **settings:** added linebreak by words not character settings


<a name="v1.0.8"></a>
### [v1.0.8] - 2021-11-16

> Config
- **headwind:** surpressed headwind error message on sorting
- **neovide:** disable blur for multigrid mode

> Features
- **codeactionmenu:** added new plugin code action menu


<a name="v1.0.7"></a>
### [v1.0.7] - 2021-11-15

> Bug Fixes
- **treesitter:** fix plugins failed to load

> Config
- **godot:** added global option to disable godot lsp if godot is installed but don't plan to use neovim for coding
- **null-ls:** mappings now always possible whenever null_ls is loaded
- **package-info:** package info now is limited to filetype json


<a name="v1.0.6"></a>
### [v1.0.6] - 2021-11-15

> Bug Fixes
- **lsp_status:** fix lsp status on airline not showing messages
- **package_info:** fix package_info yelling error on recompiling

> Features
- **tailwind-headwind:** added tailwind and headwind support

> Mappings
- **gitsigns:** added mappings to controls hunks
- **lsp:** added mappings for lsp formatting
- **packer:** added packer command mappings


<a name="v1.0.5"></a>
### [v1.0.5] - 2021-11-15

> Bug Fixes
- **telescope:** now fzf and frecency is loaded properly after telescope


<a name="v1.0.4"></a>
### [v1.0.4] - 2021-11-15

> Features
- **lsp:** added godot lsp setting
- **lspconfig:** added support for godot and tailwindcss

> Settings
- added backup settings
- added nvr integration
- added noswapfile noundofile

> Various Actions
- format

> Reverts
- feat(lsp): added godot lsp setting


<a name="v1.0.3"></a>
### [v1.0.3] - 2021-11-10

> Bug Fixes
- **windows:** more compability codes

> Code Refactoring
- **globals:** changed from using _G to vim.g

> Config
- **focus.nvim:** sign column now won't disappear on not focused windows

> Features
- **clipboard:** reenable cutlass, registers and subversibe, but removed yoink
- **focus.nvim:** added focus nvim
- **windline:** added lsp status integration to airline
- **windline:** moved from sample to local airline config

> Settings
- no backup files in writing files


<a name="v1.0.2"></a>
### [v1.0.2] - 2021-11-05

> Bug Fixes
- **lsp:** fix lsp status not initialized, and typescript lsp config not called
- **packer-init-nvim:** clone timeout raised from 600 to 3000
- **windows:** disabled some plugins and settings that are incompatible in windows

> Config
- **yoink:** added configuration

> Features
- **neoclip:** moved clipboard management to neoclip
- **neoclip:** moved clipboard management to neoclip
- **treesitter:** treesitter now not running on vscode
- **vscode:** mappings for vscode

> Linter
- **golangci:** disabled auto fix for compability reason


<a name="v1.0.1"></a>
### [v1.0.1] - 2021-11-03

> Bug Fixes
- **paths:** fix potential duplicate require

> Doc
- added changelog.md file


<a name="v1.0.0"></a>
### v1.0.0 - 2021-11-03

> Code Refactoring
- **indentation:** moved indentation to it's own folder

> Doc
- added changelog template

> Init
- initial commit


[Unreleased]: https://github.com/tigorlazuardi/nvim/compare/v3.1.5...HEAD
[v3.1.5]: https://github.com/tigorlazuardi/nvim/compare/v3.1.4...v3.1.5
[v3.1.4]: https://github.com/tigorlazuardi/nvim/compare/v3.1.3...v3.1.4
[v3.1.3]: https://github.com/tigorlazuardi/nvim/compare/v3.1.2...v3.1.3
[v3.1.2]: https://github.com/tigorlazuardi/nvim/compare/v3.1.1...v3.1.2
[v3.1.1]: https://github.com/tigorlazuardi/nvim/compare/v3.1.0...v3.1.1
[v3.1.0]: https://github.com/tigorlazuardi/nvim/compare/v3.0.3...v3.1.0
[v3.0.3]: https://github.com/tigorlazuardi/nvim/compare/v3.0.2...v3.0.3
[v3.0.2]: https://github.com/tigorlazuardi/nvim/compare/v3.0.1...v3.0.2
[v3.0.1]: https://github.com/tigorlazuardi/nvim/compare/v3.0.0...v3.0.1
[v3.0.0]: https://github.com/tigorlazuardi/nvim/compare/v2.6.0...v3.0.0
[v2.6.0]: https://github.com/tigorlazuardi/nvim/compare/v2.5.0...v2.6.0
[v2.5.0]: https://github.com/tigorlazuardi/nvim/compare/v2.4.1...v2.5.0
[v2.4.1]: https://github.com/tigorlazuardi/nvim/compare/v2.4.0...v2.4.1
[v2.4.0]: https://github.com/tigorlazuardi/nvim/compare/v2.3.1...v2.4.0
[v2.3.1]: https://github.com/tigorlazuardi/nvim/compare/v2.3.0...v2.3.1
[v2.3.0]: https://github.com/tigorlazuardi/nvim/compare/v2.2.0...v2.3.0
[v2.2.0]: https://github.com/tigorlazuardi/nvim/compare/v2.0.3...v2.2.0
[v2.0.3]: https://github.com/tigorlazuardi/nvim/compare/v2.1.0...v2.0.3
[v2.1.0]: https://github.com/tigorlazuardi/nvim/compare/v2.0.2...v2.1.0
[v2.0.2]: https://github.com/tigorlazuardi/nvim/compare/v2.0.1...v2.0.2
[v2.0.1]: https://github.com/tigorlazuardi/nvim/compare/v2.0.0...v2.0.1
[v2.0.0]: https://github.com/tigorlazuardi/nvim/compare/v1.3.1...v2.0.0
[v1.3.1]: https://github.com/tigorlazuardi/nvim/compare/v1.3.0...v1.3.1
[v1.3.0]: https://github.com/tigorlazuardi/nvim/compare/v1.2.0...v1.3.0
[v1.2.0]: https://github.com/tigorlazuardi/nvim/compare/v1.1.0...v1.2.0
[v1.1.0]: https://github.com/tigorlazuardi/nvim/compare/v1.0.9...v1.1.0
[v1.0.9]: https://github.com/tigorlazuardi/nvim/compare/v1.0.8...v1.0.9
[v1.0.8]: https://github.com/tigorlazuardi/nvim/compare/v1.0.7...v1.0.8
[v1.0.7]: https://github.com/tigorlazuardi/nvim/compare/v1.0.6...v1.0.7
[v1.0.6]: https://github.com/tigorlazuardi/nvim/compare/v1.0.5...v1.0.6
[v1.0.5]: https://github.com/tigorlazuardi/nvim/compare/v1.0.4...v1.0.5
[v1.0.4]: https://github.com/tigorlazuardi/nvim/compare/v1.0.3...v1.0.4
[v1.0.3]: https://github.com/tigorlazuardi/nvim/compare/v1.0.2...v1.0.3
[v1.0.2]: https://github.com/tigorlazuardi/nvim/compare/v1.0.1...v1.0.2
[v1.0.1]: https://github.com/tigorlazuardi/nvim/compare/v1.0.0...v1.0.1
