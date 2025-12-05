#!/bin/bash

# Parameters
transaction_file=$1

# Extract the file from the archive
bunzip2 -d "${transaction_file}"

# Get the extracted filename and "return" it
echo "${transaction_file%.bz2}"
