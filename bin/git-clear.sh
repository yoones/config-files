#!/bin/bash

git status

read -p "Really remove all these changes (y/n)?" choice
if [ "$choice" != "y" ]; then
    echo "abort."
    exit 1
fi

git stash
git stash clear
git clean -f -d

echo "done."

exit 0
