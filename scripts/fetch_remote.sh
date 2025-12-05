#!/bin/bash

# Parameters
private_key=$1
remote_server=$2
remote_userid=$3
remote_file=$4

# Validate input
if [ "$#" -lt 4 ]; then
    echo "usage: $0 <private_key> <remote_server> <remote_userid> <remote_file>" >&2
    exit 1
fi

if [[ -z "$private_key" || -z "$remote_server" || -z "$remote_userid" || -z "$remote_file" ]]; then
    echo "usage: $0 <private_key> <remote_server> <remote_userid> <remote_file>" >&2
    exit 1
fi

# Copy the remote file from the SSH server to the current working directory
if ! scp -i "$private_key" "$remote_userid"@"$remote_server":"$remote_file" .; then
    echo "($0) Error: Failed to fetch remote file" >&2
    exit 1
fi

# Get the filename
transaction_file="${remote_file##*/}"

# Verify file was downloaded
if [ ! -f "$transaction_file" ]; then
    echo "($0) Error: Downloaded file does not exist: $transaction_file" >&2
    exit 1
fi

# "Return" the filename of the remote file
echo "$transaction_file"