#!/bin/bash

# Parameters
transaction_file=$1
new_transaction_file="transaction.csv"

# Validate input
if [ -z "$transaction_file" ]; then
    echo "Error: Transaction file not provided"
    exit 1
fi

if [ ! -f "$transaction_file" ]; then
    echo "Error: Transaction file does not exist: $transaction_file"
fi

# Sort by customerID field
sort -t',' -k1,1 -o "$new_transaction_file" "$transaction_file"

# Remove the old transaction file from the working directory
rm "$transaction_file"

# "Return" the new transaction file
echo "$new_transaction_file"