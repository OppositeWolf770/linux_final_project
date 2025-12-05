#!/bin/bash

# Parameters
transaction_file=$1
new_transaction_file="transaction.csv"

# Validate input
if [ -z "$transaction_file" ]; then
    echo "Error: Transaction file not provided" >&2
    exit 1
fi

if [ ! -f "$transaction_file" ]; then
    echo "Error: Transaction file does not exist: $transaction_file" >&2
    exit 1
fi

# Sort by customerID field
if ! sort -t, -k1,1 -o "$new_transaction_file" "$transaction_file"; then
    echo "Error: Failed to sort by customerID" >&2
    exit 1
fi

# Remove the old transaction file from the working directory
if ! rm "$transaction_file"; then
    echo "Error: Failed to remove old transaction file: $transaction_file" >&2
    exit 1
fi

# "Return" the new transaction file
echo "$new_transaction_file"