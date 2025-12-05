#!/bin/bash

transaction_file=$1

# Validate input
if [ -z "$transaction_file" ]; then
	echo "usage: $0 <transaction_file>" >&2
	exit 1
fi

if [ ! -f "$transaction_file" ]; then
	echo "Error: Transaction file does not exist: $transaction_file" >&2
	exit 1
fi

# Remove header and "return" output
if ! sed -i '1d' "${transaction_file}"; then
	echo "Error: Failed to remove header from $transaction_file" >&2
	exit 1
fi