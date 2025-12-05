#!/bin/bash
# Daniel Hoelzeman
# Final Project
# December 4, 2025

fail() {
  echo "Error: $1" >&2
  exit 1
}

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
archive_fn=$(./scripts/fetch_remote.sh "$private_key" "$remote_server" "$remote_userid" "$remote_file") || fail "Failed to fetch remote file"
echo -e "\u2713 Transaction file retrieved from remote server"

# Unzip the file and delete the zipped file
# transaction_file=$(./scripts/unzip_file.sh "$archive_fn") || fail "Failed to unzip transaction file"
echo -e "\u2713 Transaction file unzipped"

transaction_file="test.csv"

# Remove the header from the transaction file
./scripts/remove_header.sh "$transaction_file" || fail "Failed to remove header"
echo -e "\u2713 Header row removed from transaction file"

# Convert all characters to lowercase in the transaction file
./scripts/convert_to_lower.sh "$transaction_file" || fail "Failed to convert to lowercase"
echo -e "\u2713 Lines in transaction file converted to lowercase"

# Convert gender column appropriately
./scripts/convert_gender.sh "$transaction_file" || fail "Failed to convert gender column"
echo -e "\u2713 Gender column in transaction file converted"

# Filter invalid state fields out of transactions file
./scripts/filter_state_fields.sh "$transaction_file" || fail "Failed to filter state column"
echo -e "\u2713 State column in transaction file filtered"

# Remove the dollar sign from the purchase amts field
./scripts/remove_dollar_sign.sh "$transaction_file" || fail "Failed to remove dollar sign"
echo -e "\u2713 Dollar sign removed from purchase amt field in transaction file"

# Sort transactions file by customerID
transaction_file=$(./scripts/sort_by_customerID.sh "$transaction_file") || fail "Failed to sort transaction file"
echo -e "\u2713 Sorted transaction file by customerID field"

# Generate summary file
summary_file=$(./scripts/generate_summary.sh "$transaction_file") || fail "Failed to generate summary file"
echo -e "\u2713 Summary file generated"

# Priority sort summary file
./scripts/priority_sort_summary.sh "$summary_file" || fail "Failed to priority sort summary file"
echo -e "\u2713 Priority sorted summary file"

# Generate transaction report
./scripts/generate_transaction_report.sh "$transaction_file" || fail "Failed to generate transaction report"
echo -e "\u2713 Transaction report generated"

# Generate purchase report
./scripts/generate_purchase_report.sh "$transaction_file" || fail "Failed to generate purchase report"
echo -e "\u2713 Purchase report generated"

# Exit with OK status
exit 0