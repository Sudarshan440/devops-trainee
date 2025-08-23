#!/bin/bash 
for fruit in Apple Mangoes Orange
do
  echo "I like all these $fruit"
  echo Total Alphabets : ${#fruit} 
done
echo " "
for Parent in car ; do
        echo "List of my Favorite Cars"
    for child in farrari bmw Amg; do
        echo "$Parent->$child"
    done
    echo " "
    for Parent1 in actors ; do
        echo "List of my Actors"
    for child1 in  Amar Akbar Anthony; do
        echo "$Parent1->$child1"
    done
    echo " "
    for Parent2 in sports ; do
        echo "List of my Favorite Sports"
    for child2 in Basketball Cricket TableTennis; do
        echo "$Parent2->$child2"
    done
done
done
done