#!/bin/bash

# Parameters
remote_server=$1
remote_userid=$2
remote_file=$3

scp "$remote_userid"@"$remote_server":"$remote_file" .

# Get the filename from the full path of the remote file
filename="${remote_file##*/}"

# "Return" the filenane of the remote file
echo "$filename"