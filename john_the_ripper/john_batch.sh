#!/bin/bash

# Function to log results
log_results() {
    echo "Results for $1:" >> result.log
    john --show "$1" >> result.log
    
    # Run john_order_crack.sh and capture output
    output=$(./john_order_crack.sh "$1")
    
    # Extract cracking method and times
    dict_time=$(echo "$output" | grep "Dictionary attack duration:" | awk '{print $4}')
    brute_time=$(echo "$output" | grep "Brute-force attack duration:" | awk '{print $4}')
    rule_time=$(echo "$output" | grep "Rule-based attack duration:" | awk '{print $4}')
    
    cracking_method=$(echo "$output" | grep "Password cracked using" | cut -d' ' -f4-)
    
    if [ -n "$cracking_method" ]; then
        echo "Cracking method: $cracking_method" >> result.log
        case "$cracking_method" in
            "dictionary attack") echo "Time taken: $dict_time seconds" >> result.log ;;
            "brute-force attack") echo "Time taken: $brute_time seconds" >> result.log ;;
            "rule-based attack") echo "Time taken: $rule_time seconds" >> result.log ;;
        esac
    else
        echo "Password not cracked" >> result.log
        echo "Dictionary attack time: $dict_time seconds" >> result.log
        echo "Brute-force attack time: $brute_time seconds" >> result.log
        echo "Rule-based attack time: $rule_time seconds" >> result.log
    fi
    echo "---------------------------------------------" >> result.log
}

# Loop through all .txt files in the current folder
for file in *.txt; do
    if [ -f "$file" ]; then
        echo "Processing $file..."
        ./john_order_crack.sh "$file"
        log_results "$file"
    fi
done

echo "All files processed. Results saved in result.log"
