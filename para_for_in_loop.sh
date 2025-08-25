#!/bin/bash

# $0 is the script name
echo "Running script: $0"

if [ "$#" -lt 4 ]; then
  echo "Usage: $0 "FRUITS" "CARS" "ACTORS" "SPORTS""
  echo "Example: $0 "Apple Mangoes Orange" "Ferrari BMW AMG" "Amar Akbar Anthony" "Basketball Cricket TableTennis""
  exit 1
fi

FRUITS=$1
CARS=$2
ACTORS=$3
SPORTS=$4

echo "Favorite Fruits:"
for fruit in $FRUITS; do
  echo "I like all these $fruit"
  echo "Total Alphabets : ${#fruit}"
done

echo -e "\nList of my Favorite Cars:"
for car in $CARS; do
  echo "car->$car"
done

echo -e "\nList of my Favorite Actors:"
for actor in $ACTORS; do
  echo "actors->$actor"
done

echo -e "\nList of my Favorite Sports:"
for sport in $SPORTS; do
  echo "sports->$sport"
done
