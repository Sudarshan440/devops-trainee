#!/bin/bash 

# Check roll number and marks as argument
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <roll_number> <marks>"
  echo "Example: $0 150 75"
  exit 1
fi

var=$1
marks=$2

if [[ "$var" -gt 150  &&"$var" -le 200 ]]; then
echo "You are the student of class A"
elif [[ "$var" -gt 100 && "$var" -le 150 ]]; then
echo "You are the student of class B"
elif [[ "$var" -gt 50 && "$var" -le 100 ]]; then
echo "You are the student of class c"
elif [[ "$var" -ge 1 && "$var" -le 50 ]]; then
echo "You are the student of class D"
else
echo "Not Defined Class!"
echo "Please Enter Valid Roll No."
fi
echo " "

if [[ $marks -ge 80 && $marks -le 100 ]]; then
    echo "You got Grade: A"
elif [[ $marks -ge 60 && $marks < 80 ]]; then
    echo "You got Grade: B"
elif [[ $marks -ge 40 && $marks < 60 ]]; then
    echo "You got Grade: C"
elif [[ $marks -ge 0 && $marks < 40 ]]; then
    echo "Sorry! You got Grade: F (Fail)"
else#!/bin/bash
echo "Iterating with \$*"
for arg in "$*"
do
    echo $arg
done

echo "Iterating with \$@"
for arg in "$@"
do
    echo $arg
done
    echo "Invalid marks entered. Please enter a value between 0 and 100."
fi

echo "Your roll no. and marks are: $@"