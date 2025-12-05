#!/bin/bash

# Parameters
transaction_file=$1

# Validate input
if [ -z "$transaction_file" ]; then
	echo "usage: $0 <transaction_file>" >&2
	exit 1
fi

if [ ! -f "$transaction_file" ]; then
	echo "($0) Error: Transaction file does not exist: $transaction_file" >&2
	exit 1
fi

# Extract the file from the archive
if ! bunzip2 -d "${transaction_file}"; then
	echo "($0) Error: Failed to extract file: $transaction_file" >&2
	exit 1
fi

# Get the extracted filename and "return" it
echo "${transaction_file%.bz2}"
