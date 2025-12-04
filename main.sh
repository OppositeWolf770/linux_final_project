#!/bin/bash
# Daniel Hoelzeman
# Final Project
# December 4, 2025

# Parameters
private_key=$1 # private-key: Full path to your local ssh private key
remote_server=$2 # remote-server: Server name or IP address
remote_userid=$3 # remote-userid: Userid to login to the remote machine
remote_file=$4 # remote-file: Full path to the remote file on the remote server


if [ "$#" -lt 4 ]; then
  echo "usage: $0 <private-key> <remote-server> <remote-userid> <remote-file> <mysql-user-id> <mysql-database>"
  exit 1
fi

# Fetch the file from the remote server
# TODO: Uncomment this code in production
# archive_fn=$(./scripts/fetch_remote.sh "$private_key" "$remote_server" "$remote_userid" "$remote_file")
echo "Transactions File retrieved from remote server"

# TODO: Remove this in production
archive_fn="MOCK_MIX_v2.1.csv.bz2"

# Unzip the file and delete the zipped file
transaction_file=$(./scripts/unzip_file.sh "$archive_fn")
echo "Transactions file unzipped"

# Remove the header from the transaction file
./scripts/remove_header.sh "$transaction_file"
echo "Header row removed from transactions file"

# Convert all characters to lowercase in the transaction file
./scripts/convert_to_lower.sh "$transaction_file"
echo "Lines in transactions file converted to lowercase"

# Convert gender column appropriately
./scripts/convert_gender.sh "$transaction_file"
echo "Gender column in transactions file converted"

# Filter invalid state fields out of transactions file
./scripts/filter_state_fields.sh "$transaction_file"
echo "State column in transactions file filtered"

# Remove the dollar sign from the purchase amts field
./scripts/remove_dollar_sign.sh "$transaction_file"


# Exit with OK status
exit 0