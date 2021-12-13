#!/bin/bash
set -e

if ! command -v lefthook &>/dev/null; then
	go install github.com/evilmartians/lefthook@latest
fi

if ! command -v git-chglog &>/dev/null; then
	go install github.com/git-chglog/git-chglog/cmd/git-chglog@latest
fi

if ! command -v selene &>/dev/null; then
	cargo install selene
fi

if ! command -v stylua &>/dev/null; then
	cargo install stylua
fi

lefthook install
