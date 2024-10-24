#!/bin/bash

# Function to handle errors
handle_error() {
    echo "Error occurred while processing $1" >&2
    echo "Error occurred while processing $1" >> batch_strong.log
}

# Set up error handling
set -e
trap 'handle_error "$BASH_COMMAND"' ERR

# Initialize log file
echo "Batch processing started at $(date)" > batch_strong.log

# Loop through all files in the current directory
for file in *; do
    # Skip .log and .sh files, and directories
    if [[ -f "$file" && "${file##*.}" != "log" && "${file##*.}" != "sh" ]]; then
        echo "Processing $file..."
        echo "Processing $file..." >> batch_strong.log
        
        # Run strong_p.sh with the current file
        ./strong_p.sh "$file" || handle_error "$file"
        
        echo "Finished processing $file"
        echo "Finished processing $file" >> batch_strong.log
        echo "----------------------------------------" >> batch_strong.log
    fi
done

echo "Batch processing completed at $(date)" >> batch_strong.log
