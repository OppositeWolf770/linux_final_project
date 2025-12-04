#!/bin/bash

# Parameters
transactions_file=$1
state_column=12

# Validate input
if [ -z "$transactions_file" ]; then
    echo "Error: Transaction file not provided"
    exit 1
fi

if [ ! -f "$transactions_file" ]; then
    echo "Error: Transaction file does not exist: $transactions_file"
fi

# If state field contains invalid values, move to exceptions_file. Otherwise, print as normal
gawk -v state_field=$state_column '
    BEGIN {
        FS=","
        OFS=","
    }

    {
        if ($state_field == "" || $12 == "na") {
            print $0 >> "exceptions.csv"
        } else {
            print $0
        }
    }
' "$transactions_file" > "${transactions_file}.tmp"

# Move temp file to input file
mv "${transactions_file}.tmp" "$transactions_file"