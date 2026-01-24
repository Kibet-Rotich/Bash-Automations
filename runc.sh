#!/bin/bash

# 1. Check if the user provided a file
if [ -z "$1" ]; then
    echo "Error: No filename provided."
    echo "Usage: $0 <filename.c>"
    exit 1
fi

SOURCE_FILE=$1
# Extract the name without the .c extension for the output binary
BINARY_NAME="${SOURCE_FILE%.*}"

# 2. Compile the file
# -o specifies the output name instead of always using a.out
# -Wall enables all common compiler warnings
echo "Compiling $SOURCE_FILE..."
if cc "$SOURCE_FILE" -Wall -o "$BINARY_NAME"; then
    echo "Compilation successful. Running..."
    echo "---------------------------------"
    
    # 3. Run the binary
    ./"$BINARY_NAME"
    
    # 4. Cleanup (Optional)
    # Uncomment the line below if you want to delete the binary after running
    # rm "$BINARY_NAME"
else
    echo "Compilation failed. Please check your code."
    exit 1
fi
