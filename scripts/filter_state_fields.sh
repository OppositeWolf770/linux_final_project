#!/bin/bash

# Parameters
transaction_file=$1
state_column=12

# Validate input
if [ -z "$transaction_file" ]; then
    echo "Error: Transaction file not provided" >&2
    exit 1
fi

if [ ! -f "$transaction_file" ]; then
    echo "Error: Transaction file does not exist: $transaction_file" >&2
    exit 1
fi

# If state field contains invalid values, move to exceptions_file. Otherwise, print as normal
gawk -v state_column=$state_column '
    BEGIN {
        FS=","
        OFS=","
    }

    {
        # Send invalid state formats to the exceptions file
        if ($state_column == "" || $state_column == "na") {
            print $0 >> "exception.csv"
        # Otherwise print as normal
        } else {
            print $0
        }
    }
' "$transaction_file" > "${transaction_file}.tmp" # Send to temp file

# Move temp file to input file
if ! mv "${transaction_file}.tmp" "$transaction_file"; then
    echo "Error: Failed to move temp file to input file" >&2
    exit 1
fi