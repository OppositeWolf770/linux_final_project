#!/bin/bash

# Parameters
transaction_file=$1
summary_file="summary.csv"

# Validate input
if [ -z "$transaction_file" ]; then
    echo "Error: Transaction file not provided"
    exit 1
fi

if [ ! -f "$transaction_file" ]; then
    echo "Error: Transaction file does not exist: $transaction_file"
fi

gawk '
BEGIN {
    FS=","
    OFS=","

    # Format for summary records
    output_pattern="%s,%s,%d,%s,%s,%.2f\n"
}

{
    # If the previous customerID matches current customerID
    if (prev == $1) {
        # Increase previous total by current amount
        prev_total = prev_total + $6

    # Otherwise if not on first line
    } else if (NR > 1) {
        # Add record to output file
        printf output_pattern, prev, prev_state, prev_zip, prev_lastname, prev_firstname, prev_total

        # Reset previous total to current amount
        prev_total = $6
    # Otherwise if on first line
    } else {
        # Initialize previous total
        prev_total = $6
    }

    # Update previous customer information with current customer information
    prev = $1               # CustomerID
    prev_state = $12        # State
    prev_zip = $13          # Zip Code
    prev_lastname = $3      # Last Name
    prev_firstname = $2     # First Name
}

END {
    # Add final record to output file
    printf output_pattern, prev, prev_state, prev_zip, prev_lastname, prev_firstname, prev_total
}

' "$transaction_file" > "$summary_file"

echo "$summary_file"