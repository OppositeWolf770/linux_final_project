#!/bin/bash

rm "MOCK_MIX_v2.1.csv"
cp "temp/MOCK_MIX_v2.1.csv.bz2" .
./main.sh ~/.ssh/id_rsa 167.99.48.123 dhoelzeman /home/shared/MOCK_MIX_v2.1.csv.bz2 blah blah