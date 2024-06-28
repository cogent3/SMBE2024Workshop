#!/bin/bash
# Check if the file doesn't exist before downloading
fname=sampled.md
if [ ! -f "/home/user/workshop/data/$fname" ]; then
    wget -O "/home/user/workshop/data/$fname" "https://www.dropbox.com/scl/fi/cox0ygzgcmdab257hikly/sample.md?rlkey=rad5dahu0nwhbrmjyx9od7mi3&dl=0"
fi
