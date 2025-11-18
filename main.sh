#!/bin/bash
# Daniel Hoelzeman
# Final Project
# December 4, 2025

# Parameters
# ($1): private-key: Full path to your local ssh private key
# ($2): remote-server: Server name or IP address
# ($3): remote-userid: Userid to login to the remote machine
# ($4): remote-file: Full path to the remote file on the remote server
# ($5): mysql-user-id: sql user id
# ($6): mysql-database: sql database name
if [ "$#" -lt 1 ]; then
  echo "usage: $0 <private-key> <remote-server> <remote-userid> <remote-file> <mysql-user-id> <mysql-database>"
fi

private_key=$1
remote_server=$2
remote_userid=$3
remote_file=$4
mysql_user_id=$5
mysql_database=$6


scp "$remote_userid"@"$remote_server":"$remote_file" .

