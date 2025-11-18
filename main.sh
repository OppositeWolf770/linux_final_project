#!/bin/bash
# Daniel Hoelzeman
# Final Project
# December 4, 2025


# Verify the arguments passed to the program
chkargs() {
  if [ "$#" -eq 0 ]; then
    echo "usage: $0 <private-key> <remote-server> <remote-userid> <remote-file>"
  fi
}

# Parameters
# ($1): private-key: Full path to your local ssh private key
# ($2): remote-server: Server name or IP address
# ($3): remote-userid: Userid to login to the remote machine
# ($4): remote-file: Full path to the remote file on the remote server


chkargs "Hello!"
