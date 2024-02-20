#!/bin/bash

# Check if an argument is given
if [ $# -ne 1 ]; then
	echo "Please give an input file!"
	exit 1
fi

# Store filename
fileName="$1"

# Check if the given file exists
if [ ! -f "$fileName" ]; then
	echo "File not found: $fileName"
	exit 1
fi

# Create an array
declare -a occurrences

# Set array values to zero
for i in {0..9}; do
	occurrences[i]=0
done

# read the file line by line
while IFS= read -r line; do
	# Check if the line is valid
	if ! [[ "$line" =~ ^[0-9]$ ]]; then
		echo "Input file is not valid!"
		exit 1
	else
		# Increment the corresponding counter
		((occurrences["$line"]++))
	fi
done <"$fileName"

# Print the result
for i in {0..9}; do
	echo -n "$i "
	occurrenceNumber="${occurrences[$i]}"
	for j in $(seq 1 $occurrenceNumber); do
		echo -n "*"
	done
	echo ""
done