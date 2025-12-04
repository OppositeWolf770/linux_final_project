#!/bin/bash

filename=$1

# Remove header and "return" output
sed -i '1d' "${filename}"