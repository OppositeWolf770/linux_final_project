#!/bin/bash

# Parameters
transaction_file=$1
state_column=12

# Validate input
if [ -z "$transaction_file" ]; then
    echo "Error: Transaction file not provided"
    exit 1
fi

if [ ! -f "$transaction_file" ]; then
    echo "Error: Transaction file does not exist: $transaction_file"
fi

# If state field contains invalid values, move to exceptions_file. Otherwise, print as normal
gawk -v state_column=$state_column '
    BEGIN {
        FS=","
        OFS=","
    }

    {
        if ($state_column == "" || $state_column == "na") {
            print $0 >> "exceptions.csv"
        } else {
            print $0
        }
    }
' "$transaction_file" > "${transaction_file}.tmp"

# Move temp file to input file
mv "${transaction_file}.tmp" "$transaction_file"