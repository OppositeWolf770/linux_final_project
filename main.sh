#!/bin/bash
# Daniel Hoelzeman
# Final Project
# December 4, 2025

# Parameters
private_key=$1 # private-key: Full path to your local ssh private key
remote_server=$2 # remote-server: Server name or IP address
remote_userid=$3 # remote-userid: Userid to login to the remote machine
# ($4): remote-file: Full path to the remote file on the remote server
# ($5): mysql-user-id: sql user id
# ($6): mysql-database: sql database name

# Error Codes
OK=0
ARG_COUNT=1

if [ "$#" -lt 1 ]; then
  echo "usage: $0 <private-key> <remote-server> <remote-userid> <remote-file> <mysql-user-id> <mysql-database>"
  exit $ARG_COUNT
fi

# TODO: Finish moving these up above with the others
remote_file=$4
mysql_user_id=$5
mysql_database=$6

# Fetch the file from the remote server
filename=$(./scripts/fetch_remote.sh "$remote_server" "$remote_userid" "$remote_file")

echo "$filename"

# 
exit $OK