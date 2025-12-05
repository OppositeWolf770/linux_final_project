#!/bin/bash

# Parameters
transaction_file=$1
gender_column=5

# Validate input
if [ -z "$transaction_file" ]; then
    echo "Error: Transaction file not provided"
    exit 1
fi

if [ ! -f "$transaction_file" ]; then
    echo "Error: Transaction file does not exist: $transaction_file"
fi

# Run gawk script to change gender field
gawk -v gender_column=$gender_column '
    BEGIN {
        FS=","
        OFS=","
    }

    {
        if ($gender_column == "1" || $gender_column == "female" || $gender_column == "f") {
            $gender_column = "f"
        } else if ($gender_column == "0" || $gender_column == "male" || $gender_column == "m") {
            $gender_column = "m"
        } else {
            $gender_column = "u"
        }

        print
    }
' "$transaction_file" > "${transaction_file}.tmp"

# Move temp file to input file
mv "${transaction_file}.tmp" "$transaction_file"