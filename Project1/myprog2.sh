#!/bin/bash
    
    #Check number of the input
    if [ "$#" -ne 2 ]; then
        echo "Invalid input. Please try again";
        exit 1;
    fi
    
    #Assign the inputs to variables
    string="$1"
    number="$2"
    length_of_string=${#string}
    length_of_number=${#number}
    #Check the length of number.
    if [ "$length_of_number" -ne 1 ] && [ "$length_of_number" -ne "$length_of_string" ]; then
        echo "Length of the number should equal 1 or length of the string"
        exit 1;
    fi
    #In this method we shift the character according to number that we take the from input
    cipher_char() {
    local char="$1"
    local shift="$2"
    local alphabet="abcdefghijklmnopqrstuvwxyz"
    local char_position
    #Assign the number according to index of character.For example character is "n", the number will be 14.
    char_position=$(expr index "$alphabet" "$char")

    if [ "$char_position" -eq 0 ]; then
        # Check the valid input.
        echo "Invalid input. Please try again."
    else
        #If the input is valid, shifting process will be executed.
        local new_position
        new_position=$(( (char_position + shift - 1) % 26 ))
        if [ "$new_position" -eq 26 ]; then
            new_position=0
        fi
        echo -n "${alphabet:$new_position:1}"
    fi
}
    #Filling the empty string with new char that is obtained from cipher_char() method.
    encrypted_string=""
    for (( i = 0; i<length_of_string; i++ )); do
        letter="${string:$i:1}"
        if [ "$length_of_number" -eq 1 ]; then
            shifter="$number"
        else
            shifter="${number:$i:1}"
        fi
       
        encrypted_char=$(cipher_char "$letter" "$shifter")
        encrypted_string="$encrypted_string$encrypted_char"
        
    done
    #Print the new shifted char or characters
    echo "$encrypted_string"