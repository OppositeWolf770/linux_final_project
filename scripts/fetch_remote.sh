#!/bin/bash

# Parameters
private_key=$1
remote_server=$2
remote_userid=$3
remote_file=$4

# Copy the remote file from the SSH server to the current working directory
scp -i "$private_key" "$remote_userid"@"$remote_server":"$remote_file" .

# Get the filename from the full path of the remote file
transaction_file="${remote_file##*/}"

# "Return" the filenane of the remote file
echo "$transaction_file"