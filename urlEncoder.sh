#!/bin/bash

# Check if an argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 'string_to_encode'"
    exit 1
fi

# Original string from the argument
original_string="$1"

# URL encode function
urlencode() {
    local string="$1"
    local encoded=""
    local length="${#string}"
    local i
    local c
    for (( i=0; i<length; i++ )); do
        c="${string:$i:1}"
        case "$c" in
            [a-zA-Z0-9./-]) encoded+="$c" ;;
            *) encoded+=$(printf '%%%02X' "'$c") ;;
        esac
    done
    echo "$encoded"
}

# Encode the original string
encoded_string=$(urlencode "$original_string")

# Output the result
echo "$encoded_string"
