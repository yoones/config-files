#!/bin/bash

date
i=$1
echo "Waiting $i seconds..."
while [ $i -gt 0 ]; do
    printf "\r%- 10d" "$i"
    sleep 1
    i=$((i-1))
done
printf "\r"
date
