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
    prev_total = 0
}

NR > 1 {
    # If the previous customerID matches current customerID
    if (prev == $1) {
        # Increase previous total
        prev_total = prev_total + prev_amt

    # Otherwise
    } else {
        # Add record to output file
        printf "%s,%s,%d,%s,%s,%f\n", prev, prev_state, prev_zip, prev_lastname, prev_firstname, prev_total

        # Reset previous total
        prev_total = 0
    }
}

{
    # Update previous customer information with current customer information
    # (Initialize if on first line)
    prev = $1               # CustomerID
    prev_amt = $6           # Purchase Amount
    prev_state = $12        # State
    prev_zip = $13          # Zip Code
    prev_lastname = $3      # Last Name
    prev_firstname = $2     # First Name
}

END {
    # Increase previous total
    prev_total = prev_total + prev_amt

    # Add final record to output file
    printf "%s,%s,%d,%s,%s,%f\n", prev, prev_state, prev_zip, prev_lastname, prev_firstname, prev_total
}

' "$transaction_file" > "$summary_file"

echo "$summary_file"