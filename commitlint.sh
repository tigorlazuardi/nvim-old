#!/bin/bash

types="build|chore|ci|docs|feat|fix|perf|refactor|revert|style|test|conf|breaking"

# Create a regex for a conventional commit.
convetional_commit_regex="^($types)(\(.+\))?!?: .+$"

# Get the commit message.
commit_message=$(cat "$1")

if [[ "$commit_message" =~ ^Merge.* ]]; then
	exit 0
fi

# Check Regex
if [[ "$commit_message" =~ $convetional_commit_regex ]]; then
	exit 0
fi

# Failed to pass regex test
echo -e "\e[31mThe commit message does not meet the Conventional Commit standard\e[0m"
echo
echo "Allowed scopes:" "$types"
echo "An example of a valid message is: "
echo "  feat(login): add the 'remember me' button"
echo "More details at: https://www.conventionalcommits.org/en/v1.0.0/#summary"
exit 1
