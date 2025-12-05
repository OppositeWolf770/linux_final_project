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
}

NR > 1 {
    if (prev == $1) {
        print "Matched!"
    } else {
        print "No Match. :("
    }
}

{
    prev = $1
}

' "$transaction_file"