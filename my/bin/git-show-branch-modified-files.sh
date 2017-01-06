#!/bin/bash

if [ "$#" != "2" ]; then
    echo "Usage: $0 <master-branch> <your-branch>"
    exit 1
fi

master_branch="$1"
your_branch="$2"

if [ "$master_branch" == "." ]; then
    master_branch=$(git branch | grep '.' | cut -d ' ' -f 2)
fi

if [ "$your_branch" == "." ]; then
    your_branch=$(git branch | grep '.' | cut -d ' ' -f 2)
fi

git diff --name-only $your_branch $(git merge-base $your_branch $master_branch) | cat
