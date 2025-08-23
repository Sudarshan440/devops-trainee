#!/bin/bash 
mkdir - p /home/ncs/sudarshan && touch /home/ncs/sudarshan/verma.txt
read -p "Enter the file name to search for: " FILENAME
read -p "Enter the directory: " SEARCH_DIR

find "$SEARCH_DIR" -name "$FILENAME" -print && echo "File Found successfully"

# cat $FILENAME

# Find and process all .txt files in the current directory
find "$SEARCH_DIR" -type f -name "*.txt" -exec echo "All files Available: {}" \; 

ls -l | grep "Aug" | sort +4n

touch sudo{1..5}.txt
ls su*.txt
rm -f sudo*.txt
# This would display all the files, the names of which start with "ch" and end with .txt 

