#!/bin/bash

# Parameters
transactions_file=$1
gender_column=5

# Validate input
if [ -z "$transactions_file" ]; then
    echo "Error: Transaction file not provided"
    exit 1
fi

if [ ! -f "$transactions_file" ]; then
    echo "Error: Transaction file does not exist: $transactions_file"
fi

# Run gawk script to change gender field
# $5: Gender column
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
' "$transactions_file" > "${transactions_file}.tmp"

# Move temp file to input file
mv "${transactions_file}.tmp" "$transactions_file"