#!/bin/bash

# Check if there are any input parameters
if [[ $# -eq 0 ]]; then
	echo "Please give input parameter!"
	exit 1
fi

if [[ $# -eq 1 ]]; then # Non-recursive case
	isRecursive=false
	wildcard=$1
elif [[ $# -eq 2 && $1 == "-R" ]]; then # Recursive case
	isRecursive=true
	wildcard=$2
else
	echo "Please give correct input parameter!"
	exit 1
fi

# Get the current working directory
cwd=$(pwd)

if [[ $isRecursive == false ]]; then
	# Find all files satisfying the given condition
	files=$(find . -maxdepth 1 -type f -name "$wildcard")
	if [[ $files ]]; then

		# Create copied folder if it doesn't exist
		if [[ ! -d "$cwd/copied" ]]; then
			mkdir copied
		fi

		# Copy files to the copied folder
		for file in $files; do
			cp "$file" "$cwd/copied"
		done
	fi
fi

if [[ $isRecursive == true ]]; then
	# Find all subdirectories
	subDirectories=$(find "$cwd" -type d)

	# Iterate over each subdirectory
	for subDirectory in $subDirectories; do

		# Find all files satisfying the given condition
		files=$(find $subDirectory -maxdepth 1 -type f -name "$wildcard")

		# Check if there are any files that match the wildcard
		if [[ $files ]]; then
			# Create copied folder if it doesn't exist
			if [[ ! -d "$subDirectory/copied" ]]; then
				mkdir "$subDirectory/copied"
			fi

			# Copy files to the copied folder
			for file in $files; do
				cp "$file" "$subDirectory/copied"
			done
		fi
	done
fi

