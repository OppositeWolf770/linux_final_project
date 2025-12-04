#!/bin/bash

# Parameters
filename=$1

# Temporary file to modify input file
temp="${filename}.tmp"

# Run gawk script to change gender field
# $5: Gender column
gawk '
BEGIN {
    FS=","
    OFS=","
}

{
    if ($5 == "1" || $5 == "female" || $5 == "f") {
        $5 = "f"
    } else if ($5 == "0" || $5 == "male" || $5 == "m") {
        $5 = "m"
    } else {
        $5 = "u"
    }

    print
}
' "$filename" > "$temp"

# Move temp file to input file
mv "$temp" "$filename"