#!/bin/bash

if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <number1> <operator> <number2>"
  echo "Operators: +, -, x, /"
  exit 1
fi

num1=$1
operator=$2
num2=$3

case "$operator" in
  "+")
    result=$((num1+num2))
    echo "$num1 + $num2 = $result"
    ;;
  "-")
    result=$((num1-num2))
    echo "$num1 - $num2 = $result"
    ;;
  "x"|"*")
    result=$((num1*num2))
    echo "$num1 * $num2 = $result"
    ;;
  "/")
    # Check for division by zero
    if [ "$num2" -eq 0 ]; then
      echo "Error: Division by zero is not allowed."
      exit 1
    fi
    result=$((num1/num2))
    echo "$num1 / $num2 = $result"
    ;;
  *)
    echo "Invalid operator. Use +, -, x, or /."
    exit 1
    ;;
esac
exit 0
