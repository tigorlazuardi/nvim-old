
<a name="v1.0.3"></a>
## [v1.0.3](https://github.com/tigorlazuardi/nvim/compare/v1.0.2...v1.0.3)

> 2021-11-10

### Config

* `focus.nvim`: sign column now won't disappear on not focused windows

### Feat

* `clipboard`: reenable cutlass, registers and subversibe, but removed yoink
* `focus.nvim`: added focus nvim
* `windline`: added lsp status integration to airline
* `windline`: moved from sample to local airline config

### Fix

* `windows`: more compability codes

### Refactor

* `globals`: changed from using _G to vim.g

### Settings

* no backup files in writing files


<a name="v1.0.2"></a>
## [v1.0.2](https://github.com/tigorlazuardi/nvim/compare/v1.0.1...v1.0.2)

> 2021-11-05

### Config

* `yoink`: added configuration

### Feat

* `neoclip`: moved clipboard management to neoclip
* `neoclip`: moved clipboard management to neoclip
* `treesitter`: treesitter now not running on vscode
* `vscode`: mappings for vscode

### Fix

* `lsp`: fix lsp status not initialized, and typescript lsp config not called
* `packer-init-nvim`: clone timeout raised from 600 to 3000
* `windows`: disabled some plugins and settings that are incompatible in windows

### Linter

* `golangci`: disabled auto fix for compability reason


<a name="v1.0.1"></a>
## [v1.0.1](https://github.com/tigorlazuardi/nvim/compare/v1.0.0...v1.0.1)

> 2021-11-03

### Doc

* added changelog.md file

### Fix

* `paths`: fix potential duplicate require


<a name="v1.0.0"></a>
## v1.0.0

> 2021-11-03

### Doc

* added changelog template

### Init

* initial commit

### Refactor

* `indentation`: moved indentation to it's own folder

