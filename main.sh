#!/bin/bash
# Daniel Hoelzeman
# Final Project
# December 4, 2025

# Parameters
private_key=$1 # private-key: Full path to your local ssh private key
remote_server=$2 # remote-server: Server name or IP address
remote_userid=$3 # remote-userid: Userid to login to the remote machine
remote_file=$4 # remote-file: Full path to the remote file on the remote server
mysql_user_id=$5 # mysql-user-id: sql user id
mysql_database=$6 # mysql-database: sql database name

# Error Codes
OK=0
ERR_ARG_COUNT=1

if [ "$#" -lt 6 ]; then
  echo "usage: $0 <private-key> <remote-server> <remote-userid> <remote-file> <mysql-user-id> <mysql-database>"
  exit $ERR_ARG_COUNT
fi

# Fetch the file from the remote server
# TODO: Uncomment this code in production
# archive_fn=$(./scripts/fetch_remote.sh "$private_key" "$remote_server" "$remote_userid" "$remote_file")

# TODO: Remove this in production
archive_fn="MOCK_MIX_v2.1.csv.bz2"

# Unzip the file and delete the zipped file
transaction_file=$(./scripts/unzip_file.sh "$archive_fn")

# Remove the header from the transaction file
./scripts/remove_header.sh "$transaction_file"

# Convert all characters to lowercase in the transaction file
./scripts/convert_to_lower.sh "${transaction_file}"

# Convert gender field appropriately
./scripts/convert_gender.sh "${transaction_file}"

# Exit with OK status
exit $OK