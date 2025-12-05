#!/bin/bash

# Parameters
transaction_file=$1
transaction_report="transaction.rpt"
output_format="%-5s\t%-17s\n"

# Validate input
if [ -z "$transaction_file" ]; then
    echo "usage: $0 <transaction_file>"
    exit 1
fi

if [ ! -f "$transaction_file" ]; then
    echo "($0) Error: Transaction file does not exist: $transaction_file"
    exit 1
fi

# Empty transaction_report if it already exists
echo -n "" > "$transaction_report"

# Header lines
echo "Report by: Daniel Hoelzeman" >> "$transaction_report"
echo -e "Transaction Count Report\n" >> "$transaction_report"

printf "$output_format" "State" "Transaction Count" >> "$transaction_report"

# Cut the state column from the transaction file
cut -d "," -f 12 "$transaction_file" |\
    # Sort the states
    sort |\
    # Get the count of each unique state value
    uniq -c |\
    # Sort the number of occurrences numerically in reverse order
    sort -k1nr |\

    # Format each line into transaction report
    gawk -v output_format="$output_format" '
    {
        printf output_format, toupper($2), $1 >> "transaction.rpt"
    }
    '
