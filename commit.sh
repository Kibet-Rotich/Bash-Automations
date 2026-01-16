#!/usr/bin/env bash

set -u

# Usage: commit.sh "commit message" [branch]
# If branch is omitted, the script pushes to the current branch.

COMMIT_MESSAGE=${1:-}
BRANCH=${2:-$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "")}

if [ -z "${BRANCH}" ]; then
	echo "Error: unable to determine git branch. Are you in a git repo?"
	exit 1
fi

if [ -z "${COMMIT_MESSAGE}" ]; then
	echo "Error: commit message required. Usage: commit.sh \"message\" [branch]"
	exit 2
fi

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
	echo "Error: not a git repository"
	exit 3
fi

git add -A

if git commit -m "${COMMIT_MESSAGE}"; then
	echo "Committed: ${COMMIT_MESSAGE}"
else
	echo "No new commits created (possibly no changes). Proceeding to push the branch '${BRANCH}'..."
fi

git push origin "${BRANCH}"

if [ $? -eq 0 ]; then
	echo "Changes pushed to remote repo successfully"
	echo "Commit: ${COMMIT_MESSAGE}"
else
	echo "git push failed"
	exit 4
fi
