#!/bin/bash

# Get the base name of the hash file without extension
log_file="${hash_file%.*}.log"

# Function to print separator
print_separator() {
    echo "---------------------------------------------"
    echo "---------------------------------------------" >> "$log_file"
}

# Function to show results
show_results() {
    echo "Results:"
    echo "Results:" >> "$log_file"
    john --show "$hash_file" | tee -a "$log_file"
}

# Check if hash file is provided as argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 <hash_file>"
    exit 1
fi

hash_file="$1"
log_file="${hash_file%.*}.log"

# Initialize log file
echo "Cracking attempt for $hash_file" > "$log_file"
date >> "$log_file"
print_separator

# Brute-force attack
echo "Starting brute-force attack using John the Ripper..."
echo "Starting brute-force attack using John the Ripper..." >> "$log_file"
echo "Hash file: $hash_file"
echo "Hash file: $hash_file" >> "$log_file"
print_separator

start_time=$(date +%s)
timeout 3600 john --incremental=ASCII --min-length=1 --max-length=13 "$hash_file"
end_time=$(date +%s)
brute_duration=$((end_time - start_time))

print_separator
echo "Brute-force attack completed or timed out after 1 hour."
echo "Brute-force attack completed or timed out after 1 hour." >> "$log_file"
echo "Duration: $brute_duration seconds"
echo "Duration: $brute_duration seconds" >> "$log_file"
show_results

if ! grep -q '0 password hashes cracked' <(john --show "$hash_file"); then
    echo "Brute-force attack successful!" | tee -a "$log_file"
    echo "Password cracked using brute-force attack" | tee -a "$log_file"
    echo "Cracking method: Brute-force" >> "$log_file"
    echo "Time taken: $brute_duration seconds" >> "$log_file"
    echo "Success: Yes" >> "$log_file"
    exit 0
fi

# Rule-based attack
echo "Starting rule-based attack using John the Ripper..."
echo "Starting rule-based attack using John the Ripper..." >> "$log_file"
echo "Hash file: $hash_file"
echo "Hash file: $hash_file" >> "$log_file"
print_separator

start_time=$(date +%s)
timeout 3600 john --wordlist=/usr/share/wordlists/rockyou.txt --rules=Jumbo "$hash_file"
end_time=$(date +%s)
rule_duration=$((end_time - start_time))

print_separator
echo "Rule-based attack completed or timed out after 1 hour."
echo "Rule-based attack completed or timed out after 1 hour." >> "$log_file"
echo "Duration: $rule_duration seconds"
echo "Duration: $rule_duration seconds" >> "$log_file"
show_results

if grep -q '0 password hashes cracked' <(john --show "$hash_file"); then
    echo "All attacks unsuccessful. Password not cracked." | tee -a "$log_file"
    echo "Cracking method: Brute-force, Rule-based" >> "$log_file"
    echo "Time taken: $((brute_duration + rule_duration)) seconds" >> "$log_file"
    echo "Success: No" >> "$log_file"
else
    echo "Rule-based attack successful!" | tee -a "$log_file"
    echo "Password cracked using rule-based attack" | tee -a "$log_file"
    echo "Cracking method: Rule-based" >> "$log_file"
    echo "Time taken: $((brute_duration + rule_duration)) seconds" >> "$log_file"
    echo "Success: Yes" >> "$log_file"
fi

# Print all durations for logging
echo "Brute-force attack duration: $brute_duration seconds" | tee -a "$log_file"
echo "Rule-based attack duration: $rule_duration seconds" | tee -a "$log_file"
