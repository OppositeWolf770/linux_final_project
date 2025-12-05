#!/bin/bash

transaction_file=$1

# Remove header and "return" output
sed -i '1d' "${transaction_file}"