#!/bin/bash 

read -p "Enter your roll number: " var

if [ "$var" -le 150 ]; then
echo "You are the student of class A"
elif [[ "$var" -ge 100 && "$var" -le 150 ]]; then
echo "You are the student of class B"
elif [[ "$var" -ge 50 && "$var" -le 100 ]]; then
echo "You are the student of class c"
elif [ "$var" -gt 150 ]; then
echo "Not Defined Class!"
echo "Please Enter Valid Roll No."
else
echo "You are the student of class D"
fi
echo " "
read -p "Enter the student's marks: " marks

if [[ $marks -ge 80 && $marks -le 100 ]]; then
    echo "You got Grade: A"
elif [[ $marks -ge 60 && $marks < 80 ]]; then
    echo "You got Grade: B"
elif [[ $marks -ge 40 && $marks < 60 ]]; then
    echo "You got Grade: C"
elif [[ $marks -ge 0 && $marks < 40 ]]; then
    echo "Sorry! You got Grade: F (Fail)"
else
    echo "Invalid marks entered. Please enter a value between 0 and 100."
fi