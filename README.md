# Cybersec_final

This is a repository for the final project of the Cybersecurity course at the University of Loughborough.

The project is use a password cracking tool John the Ripper that uses a combination of dictionary, brute-force and rule-based attacks to crack encrypted pdf, word and zip files.


# Script Descriptions

## john_order_crack.sh
This script attempts to crack password hashes using John the Ripper with three different attack methods: dictionary, brute-force, and rule-based. It logs the duration of each attack and whether the password was successfully cracked. The script takes a hash file as an argument and outputs the results to the console.

## john_batch.sh
This script processes all `.txt` files in the current directory, attempting to crack their password hashes using John the Ripper. It logs the results of each file, including the cracking method used and the time taken for each attack. The results are saved in `result.log`.

## strong_p.sh
This script performs a brute-force and rule-based attack on a given hash file using John the Ripper. It logs the progress and results of each attack to a log file named after the hash file. The script takes a hash file as an argument and outputs the results to both the console and the log file.

# Crack Results
All the crack results are saved in the results folder.

## Result.log 
The `result.log` file contains the results of the password cracking attempts for various hash files. Each entry in the log provides detailed information about the cracking process, including:

- The name of the hash file.
- The password that was cracked (if successful).
- The number of password hashes cracked and the number left.
- The cracking method used (e.g., dictionary attack, brute-force attack, rule-based attack).
- The time taken for each attack method.

Take the pdf result for example:
The cracking results for the PDF files in `result.log` show a mix of successes and failures. Here's a brief analysis:

- **Successful Cracks:**
  - `1pdf_hash.txt`: Cracked using a dictionary attack. Password: `password123`
  - `2pdf_hash.txt`: Cracked using a dictionary attack. Password: `qwerty`
  - `3pdf_hash.txt`: Cracked using a dictionary attack. Password: `P@ssw0rd`

- **Failed Cracks:**
  - `4pdf_hash.txt`: Not cracked. Dictionary attack took 5 seconds, brute-force attack took 180 seconds, and rule-based attack took 180 seconds.
  - `5pdf_hash.txt`: Not cracked. Dictionary attack took 5 seconds, brute-force attack took 180 seconds, and rule-based attack took 181 seconds.

The successful cracks were all achieved using dictionary attacks, indicating that the passwords were relatively weak and commonly found in password dictionaries. The failed attempts, despite using multiple attack methods, suggest that the passwords for `4pdf_hash.txt` and `5pdf_hash.txt` are more complex and not easily guessable using standard dictionary, brute-force, or rule-based attacks.


