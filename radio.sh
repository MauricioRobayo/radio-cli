#!/bin/bash

realpath="$(realpath $0)"
radiostations="${realpath%/*}/radiostations"

if [[ "$1" =~ ^http ]]; then
   printf "Name for '$1': " 
   read name
   echo "${name},${1}" >> "$radiostations"
else
    i=0
    while read -r line; do
        let i++
        printf "%d) %s\n" $i "$(echo $line | cut -d',' -f1)"
    done < $radiostations
    printf "\nStation number? "
    read station
    stream=$(tail -n+${station} "$radiostations" | head -n1 | cut -d',' -f2)
    mpv "$stream"
fi
