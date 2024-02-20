#!/bin/bash

# Check if an argument is given
if [ $# -ne 1 ]; then
	echo "Please enter an input parameter"
	exit 1
fi

# Store the filename
fileName="$1"

# Check if the file exists
if [ ! -f "$fileName" ]; then
	echo "File not found"
	exit 1
fi

# Create a temp file
temp=$(mktemp)

# Read the input file character by character
while IFS= read -n 1 -r char; do
	# Replace each number with corresponding text
	case "$char" in
	"0") echo -n "zero" ;;
	"1") echo -n "one" ;;
	"2") echo -n "two" ;;
	"3") echo -n "three" ;;
	"4") echo -n "four" ;;
	"5") echo -n "five" ;;
	"6") echo -n "six" ;;
	"7") echo -n "seven" ;;
	"8") echo -n "eight" ;;
	"9") echo -n "nine" ;;
	*) echo -n "$char" ;; 
	esac

done <"$fileName" >"$temp"

# Move temp file to original file
mv "$temp" "$fileName"

echo "$fileName"

