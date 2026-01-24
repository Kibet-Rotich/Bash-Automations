#!/bin/bash

# 1. Check if a filename was actually provided
if [ -z "$1" ]; then
    echo "Usage: $0 <filename.c>"
    exit 1
fi

FILENAME=$1

# 2. Use a Heredoc to write the entire file at once
cat <<EOF > "$FILENAME"
#include <stdio.h>

int main() {
    printf("Hello world\n");
    return 0;
}
EOF

echo "File '$FILENAME' created successfully."
