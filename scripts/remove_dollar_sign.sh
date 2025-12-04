#!/bin/bash

# Parameters
transactions_file=$1

# Validate input
if [ -z "$transactions_file" ]; then
    echo "Error: Transaction file not provided"
    exit 1
fi

if [ ! -f "$transactions_file" ]; then
    echo "Error: Transaction file does not exist: $transactions_file"
fi

# Remove the dollar sign from the transactions file
sed -i 's/\$//g' "$transactions_file"