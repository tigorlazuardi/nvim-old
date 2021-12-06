<a name="unreleased"></a>
## [Unreleased]

### Config
- **textobjects:** textobject is now loaded by vim-texobj-user


<a name="v2.0.1"></a>
## [v2.0.1] - 2021-12-05
### Fix
- **bug-empty-file:** fixed bug empty file on open
- **vscode-compability:** packerload moved to packer.loader


<a name="v2.0.0"></a>
## [v2.0.0] - 2021-12-05
### Feat
- **lsp-lua:** added lsp lua config for windows
- **neovim:** all plugins are lazyloaded
- **taplo-lsp:** added lsp support for taplo

### Fix
- **neoclip:** changed neoclip open to ge from <c-r>
- **rust_lsp:** proper path handling on require
- **tailwind-lsp:** autostart set back to true but depends on filetypes


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
- **null_ls:** enabled autostart

### Doc
- change changelog template

### Fix
- **lefthook:** removed double changelog running

### Mappings
- **diagnostic:** gn now shows line diagnostic, gN show workspace. gnn show next. gnp show previous

### WIP
- **buffer-mapping:** bootstrapped buffer mapping

### Wip
- **calltree:** bootstrapped calltree

### Reverts
- conf(lefthook): reword pipe names


<a name="v1.0.9"></a>
## [v1.0.9] - 2021-11-16
### Config
- **settings:** added linebreak by words not character settings

### Fix
- **selene:** fix vim global not set


<a name="v1.0.8"></a>
## [v1.0.8] - 2021-11-16
### Config
- **headwind:** surpressed headwind error message on sorting
- **neovide:** disable blur for multigrid mode

### Feat
- **codeactionmenu:** added new plugin code action menu


<a name="v1.0.7"></a>
## [v1.0.7] - 2021-11-15
### Config
- **godot:** added global option to disable godot lsp if godot is installed but don't plan to use neovim for coding
- **null-ls:** mappings now always possible whenever null_ls is loaded
- **package-info:** package info now is limited to filetype json

### Fix
- **treesitter:** fix plugins failed to load


<a name="v1.0.6"></a>
## [v1.0.6] - 2021-11-15
### Feat
- **tailwind-headwind:** added tailwind and headwind support

### Fix
- **lsp_status:** fix lsp status on airline not showing messages
- **package_info:** fix package_info yelling error on recompiling

### Mappings
- **gitsigns:** added mappings to controls hunks
- **lsp:** added mappings for lsp formatting
- **packer:** added packer command mappings


<a name="v1.0.5"></a>
## [v1.0.5] - 2021-11-15
### Fix
- **telescope:** now fzf and frecency is loaded properly after telescope


<a name="v1.0.4"></a>
## [v1.0.4] - 2021-11-15
### Chore
- format

### Feat
- **lsp:** added godot lsp setting
- **lspconfig:** added support for godot and tailwindcss

### Settings
- added backup settings
- added nvr integration
- added noswapfile noundofile

### Reverts
- feat(lsp): added godot lsp setting


<a name="v1.0.3"></a>
## [v1.0.3] - 2021-11-10
### Config
- **focus.nvim:** sign column now won't disappear on not focused windows

### Feat
- **clipboard:** reenable cutlass, registers and subversibe, but removed yoink
- **focus.nvim:** added focus nvim
- **windline:** added lsp status integration to airline
- **windline:** moved from sample to local airline config

### Fix
- **windows:** more compability codes

### Refactor
- **globals:** changed from using _G to vim.g

### Settings
- no backup files in writing files


<a name="v1.0.2"></a>
## [v1.0.2] - 2021-11-05
### Config
- **yoink:** added configuration

### Feat
- **neoclip:** moved clipboard management to neoclip
- **neoclip:** moved clipboard management to neoclip
- **treesitter:** treesitter now not running on vscode
- **vscode:** mappings for vscode

### Fix
- **lsp:** fix lsp status not initialized, and typescript lsp config not called
- **packer-init-nvim:** clone timeout raised from 600 to 3000
- **windows:** disabled some plugins and settings that are incompatible in windows

### Linter
- **golangci:** disabled auto fix for compability reason


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


[Unreleased]: https://github.com/tigorlazuardi/nvim/compare/v2.0.1...HEAD
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
