#!/bin/bash

#This program helps you to remove the oldest file in the directory you entered as an argument.

#If you do not give any argument, program removes the oldest file in the working directory.

#Therefore initially we should check whether we have an input as an argument or not.

#First we need to see if there is an argument given as input.
#If we have an argument, we will delete the oldest file in given directory
if [ $# -eq 1 ]; then

	#In this case we can obviously see that number of argument is one
    #So we should remove the file in the given directory
    input_argument_directory="$1"
		
	#Lets check whether our directory exist or not
    #If not, it will terminate
    if [ -d "$input_argument_directory" ]; then
	
	    #Directory is Found, find the oldest file
		oldest_file_to_remove=$(find "$input_argument_directory" -maxdepth 1 -type f -printf '%T+ %p\n' | sort | head -1 | awk '{print $2}')
		
		#Ask permission from user
    echo "Do you want to delete $(basename "$oldest_file_to_remove")? (y/n) : "
		
		#Read reply
        read response_of_user
	
	    #If permission is not denied, remove the file
        if [ "$response_of_user" = "y" ]; then
	        rm "$oldest_file_to_remove"
        fi
    fi
else

    #This part has no arguments so delete the oldest file according to current working directory
	
    #Get working directory
    current_working_directory=$(pwd)
	
	#Now search for oldest file
    oldest_file_to_remove=$(find "$current_working_directory" -maxdepth 1 -type f -printf '%T+ %p\n' | sort | head -1 | awk '{print $2}')

	#Ask permission from user
    echo "Do you want to delete $(basename "$oldest_file_to_remove")? (y/n) : "
	
	#Read reply
    read response_of_user
    
	#If permission is not denied, remove the file
    if [ "$response_of_user" = "y" ]; then
	    rm "$oldest_file_to_remove"
    fi
fi