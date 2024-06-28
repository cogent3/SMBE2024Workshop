#!/bin/bash
# Check if the file doesn't exist before downloading
fname=apes_112.tar.gz
if [ ! -f "/home/user/workshop/data/$fname" ]; then
    wget -O "/home/user/workshop/data/$fname" "https://www.dropbox.com/s/swak1tjpvn1u5qv/apes_112.tar.gz?dl=0"
fi
