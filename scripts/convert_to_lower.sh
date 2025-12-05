#!/bin/bash

# Parameters
transaction_file=$1

# Validate input
if [ -z "$transaction_file" ]; then
    echo "Error: Transaction file not provided"
    exit 1
fi

if [ ! -f "$transaction_file" ]; then
    echo "Error: Transaction file does not exist: $transaction_file"
fi

gawk -F',' '
    {
        print tolower($0)
    }
' "$transaction_file" > "${transaction_file}.tmp"

# Move temp file to input file
mv "${transaction_file}.tmp" "$transaction_file"