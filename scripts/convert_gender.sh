#!/bin/bash

# Parameters
transaction_file=$1
gender_column=5

# Validate input
if [ -z "$transaction_file" ]; then
    echo "usage: $0 <transaction_file>" >&2
    exit 1
fi

if [ ! -f "$transaction_file" ]; then
    echo "($0) Error: Transaction file does not exist: $transaction_file" >&2
    exit 1
fi

# Run gawk script to change gender field
gawk -v gender_column=$gender_column '
    BEGIN {
        FS=","
        OFS=","
    }

    {
        # Convert female values to "f"
        if ($gender_column == "1" || $gender_column == "female" || $gender_column == "f") {
            $gender_column = "f"
        # Convert male values to "m"
        } else if ($gender_column == "0" || $gender_column == "male" || $gender_column == "m") {
            $gender_column = "m"
        # Convert all other values to "u"
        } else {
            $gender_column = "u"
        }

        # Print the full line after modification
        print
    }
' "$transaction_file" > "${transaction_file}.tmp"

# Move temp file to input file
if ! mv "${transaction_file}.tmp" "$transaction_file"; then
    echo "($0) Error: Failed to move temp file to input file" >&2
    exit 1
fi