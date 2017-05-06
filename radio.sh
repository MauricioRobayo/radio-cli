#!/bin/bash

realpath="$(realpath $0)"
radiostations="${realpath%/*}/radio-stations"
i=0
while read -r line; do
    let i++
    printf "%d) %s\n" $i "$(echo $line | cut -d',' -f1)"
done < $radiostations
printf "\nStation number? "
read station
stream=$(tail -n+${station} $radiostations | head -n1 | cut -d',' -f2)
mpv $stream
