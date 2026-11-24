#!/usr/bin/env bash

# Robustness settings
set -euo pipefail 

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Helper function for logs
log() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# 1. Environment Checks
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    error "Not a git repository. Move to a repo and try again."
    exit 1
fi

# 2. Variable Setup
COMMIT_MESSAGE=${1:-}
BRANCH=${2:-$(git rev-parse --abbrev-ref HEAD)}

if [ -z "$COMMIT_MESSAGE" ]; then
    error "Missing commit message!"
    echo "Usage: ./commit.sh \"your message\" [optional_branch]"
    exit 2
fi

# 3. Detect large files (>50MB) that are NOT ignored by Git
RAW_LARGE_FILES=$(find . -type f -size +50M -not -path '*/.*' | sed 's|^./||' || true)
LARGE_FILES=""

if [ -n "$RAW_LARGE_FILES" ]; then
    while IFS= read -r file; do
        # Skip empty lines
        [ -z "$file" ] && continue
        
        # If git check-ignore returns 1, it means the file is NOT ignored
        if ! git check-ignore -q "$file"; then
            if [ -z "$LARGE_FILES" ]; then
                LARGE_FILES="$file"
            else
                LARGE_FILES="$LARGE_FILES"$'\n'"$file"
            fi
        fi
    done <<< "$RAW_LARGE_FILES"
fi

if [ -n "$LARGE_FILES" ]; then
    warn "Unignored large files detected that might fail on GitHub:"
    echo "$LARGE_FILES"
    read -p "Do you still want to proceed? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then exit 1; fi
fi

# 4. Sync with Remote
log "Pulling latest changes from origin/$BRANCH to avoid conflicts..."
git pull origin "$BRANCH" --rebase || warn "Pull failed, proceeding anyway (might be a new branch)."

# 5. Staging and Committing
log "Staging changes..."
git add -A

# Check if there is actually anything to commit
if git diff-index --quiet HEAD --; then
    warn "No changes detected. Nothing to commit."
else
    git commit -m "$COMMIT_MESSAGE"
    log "Committed: $COMMIT_MESSAGE"
fi

# 6. Pushing
log "Pushing to origin/$BRANCH..."
if git push origin "$BRANCH"; then
    log "✅ Everything is up to date!"
else
    error "Push failed! Check for merge conflicts or network issues."
    exit 3
fi
