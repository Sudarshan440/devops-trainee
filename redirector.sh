#!/bin/bash 

timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
echo "Current formatted timestamp: $timestamp"

echo "Good morning!"
mkdir -p sudarshan
echo -e "Good morning\n$(date '+%Y-%m-%d %H:%M:%S')" >> /home/ncs/sudarshan/greeting.txt
# echo -e: Enables interpretation of escape characters like \n for a newline

echo "Your File is Created successfully!"