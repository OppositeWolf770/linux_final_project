#!/bin/bash

# Parameters
transaction_file=$1
purchase_report="purchase.rpt"
output_format="%-5s\t%-6s\t%.2f\n"

# Validate input
if [ -z "$transaction_file" ]; then
    echo "usage: $0 <transaction_file>" >&2
    exit 1
fi

if [ ! -f "$transaction_file" ]; then
    echo "($0) Error: Transaction file does not exist: $transaction_file" >&2
    exit 1
fi

# Empty purchase report if it already exists

if ! echo -n "" > "$purchase_report"; then
    echo "($0) Error: Failed to empty purchase report file: $purchase_report" >&2
    exit 1
fi

# Header lines
echo "Report by: Daniel Hoelzeman" >> "$purchase_report"
echo -e "Purchase Summary Report\n" >> "$purchase_report"

printf "%-5s\t%-6s\t%s\n" "State" "Gender" "Report" >> "$purchase_report"

# Total up the values
gawk '
    BEGIN {
        FS=","
    }
    {
        # Store values on current line
        state = toupper($12)
        gender = toupper($5)
        amount = $6

        # Store state and gender to access later
        key = state "," gender

        # Increment the total for that combination
        total[key] += amount
    }

    END {
        # Loop over each combination and split up the results
        for (key in total) {
            split(key, parts, ",")
            printf "%s %s %.2f\n", parts[1], parts[2], total[key]
        }
    }
' "$transaction_file" |\
    # Sort by purchase amount in descending numerical order, then state, then gender
    sort -k3nr -k1 -k2 |\
    # Format each line into purchase summary report
    gawk -v output_format="$output_format" '
        {
            printf output_format, $1, $2, $3
        }
    ' >> "$purchase_report"

if [ $? -ne 0 ]; then
    echo "($0) Error: Failed to generate purchase report" >&2
    exit 1
fi