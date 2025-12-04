#!/bin/bash

# Parameters
filename=$1

# Temporary file to modify input file
temp="${filename}.tmp"

gawk '
BEGIN {
    FS=","
    OFS=","
}

{
    print tolower($0)
}
' "$filename" > "$temp"

# Move temp file to input file
mv "$temp" "$filename"