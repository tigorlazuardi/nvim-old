<a name="unreleased"></a>
## [Unreleased]

### Feat
- **fine-cmdline:** added new plugin fine-cmdline
- **lightspeed:** added lightspeed plugin
- **neovide:** added keymaps to increase or decrease font size in neovide


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


[Unreleased]: https://github.com/tigorlazuardi/nvim/compare/v1.1.0...HEAD
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
