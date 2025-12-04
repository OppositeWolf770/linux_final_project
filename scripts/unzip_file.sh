#!/bin/bash

# Parameters
filename=$1

# Extract the file from the archive
bunzip2 -d "${filename}"

# Get the extracted filename and "return" it
echo "${filename%.bz2}"
