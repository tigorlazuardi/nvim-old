#!/bin/bash
set -e

go install github.com/evilmartians/lefthook@latest
go install github.com/git-chglog/git-chglog/cmd/git-chglog@latest
cargo install selene
cargo install stylua
pip install MarkdownPP

lefthook install
