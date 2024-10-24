#!/bin/bash

# Function to print separator
print_separator() {
    echo "---------------------------------------------"
}

# Function to show results
show_results() {
    echo "Results:"
    john --show "$hash_file"
}

# Check if hash file is provided as argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 <hash_file>"
    exit 1
fi

hash_file="$1"

# Dictionary attack
echo "Starting dictionary attack using John the Ripper..."
echo "Wordlist: /usr/share/wordlists/rockyou.txt"
echo "Hash file: $hash_file"
print_separator

start_time=$(date +%s)
timeout 5s john --wordlist=/usr/share/wordlists/rockyou.txt "$hash_file"
end_time=$(date +%s)
dict_duration=$((end_time - start_time))

print_separator
echo "Dictionary attack completed."
echo "Duration: $dict_duration seconds"
show_results

# Check if password was cracked
if ! grep -q '0 password hashes cracked' <(john --show "$hash_file"); then
    echo "Dictionary attack successful!"
    echo "Password cracked using dictionary attack"
    exit 0
fi

# Brute-force attack
echo "Starting brute-force attack using John the Ripper..."
echo "Hash file: $hash_file"
print_separator

start_time=$(date +%s)
timeout 180s john --incremental=ASCII --min-length=1 --max-length=13 "$hash_file"
end_time=$(date +%s)
brute_duration=$((end_time - start_time))

print_separator
echo "Brute-force attack completed or timed out after 180 seconds."
echo "Duration: $brute_duration seconds"
show_results

if ! grep -q '0 password hashes cracked' <(john --show "$hash_file"); then
    echo "Brute-force attack successful!"
    echo "Password cracked using brute-force attack"
    exit 0
fi

# Rule-based attack
echo "Starting rule-based attack using John the Ripper..."
echo "Hash file: $hash_file"
print_separator

start_time=$(date +%s)
timeout 180s john --wordlist=/usr/share/wordlists/rockyou.txt --rules=Jumbo "$hash_file"
end_time=$(date +%s)
rule_duration=$((end_time - start_time))

print_separator
echo "Rule-based attack completed or timed out after 180 seconds."
echo "Duration: $rule_duration seconds"
show_results

if grep -q '0 password hashes cracked' <(john --show "$hash_file"); then
    echo "All attacks unsuccessful. Password not cracked."
else
    echo "Rule-based attack successful!"
    echo "Password cracked using rule-based attack"
fi

# Print all durations for logging
echo "Dictionary attack duration: $dict_duration seconds"
echo "Brute-force attack duration: $brute_duration seconds"
echo "Rule-based attack duration: $rule_duration seconds"
