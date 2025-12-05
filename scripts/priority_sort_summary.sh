#!/bin/bash

# Parameters
summary_file=$1

# Validate input
if [ -z "$summary_file" ]; then
    echo "usage: $0 <summary_file>" >&2
    exit 1
fi

if [ ! -f "$summary_file" ]; then
    echo "Error: Summary file does not exist: $summary_file" >&2
    exit 1
fi

# Priority sort into temporary output file
# Sort order: State, Zip Code, Last Name, First Name
if ! sort -t, -k2,2 -k3,3n -k4,4 -k5,5 "$summary_file" > "${summary_file}.tmp"; then
    echo "Error: Failed to sort summary file: $summary_file" >&2
    exit 1
fi

# Move temporary file into summary_file
if ! mv "${summary_file}.tmp" "$summary_file"; then
    echo "Error: Failed to move sorted file to summary file" >&2
    exit 1
fi