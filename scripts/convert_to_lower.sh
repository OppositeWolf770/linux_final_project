#!/bin/bash

# Parameters
transaction_file=$1

# Validate input
if [ -z "$transaction_file" ]; then
    echo "usage: $0 <transaction_file>" >&2
    exit 1
fi

if [ ! -f "$transaction_file" ]; then
    echo "($0) Error: Transaction file does not exist: $transaction_file" >&2
    exit 1
fi

# Convert every character in every line to lowercase and send to temporary file
gawk -F',' '
    {
        print tolower($0)
    }
' "$transaction_file" > "${transaction_file}.tmp"

# Move temp file to input file
if ! mv "${transaction_file}.tmp" "$transaction_file"; then
    echo "($0) Error: Failed to move temp file to input file" >&2
    exit 1
fi