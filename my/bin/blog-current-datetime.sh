#!/bin/bash

t=$(date +'%A %d/%m/%Y, %H:%M')
l=$(echo -n $t | wc -m)

echo ""
echo $t
i=0
while [ "$i" != "$l" ]; do
    echo -n '-'
    i=$((i+1))
done
echo ""
echo ""
