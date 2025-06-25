#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status.

git config --global init.defaultBranch main

mv .git/config config
mv .git/HEAD HEAD

rm -rf .git

git init -b main

mv config .git/config
mv HEAD .git/HEAD

git checkout -b main

touch .gitignore
echo ".gitignore
0-*
1-*
2-*
3-*
4-*
5-*
6-*
7-*
8-*
9-*
up*
setup-*" | tee .gitignore

git add --all .

git commit -m "monthly cleanup"

git push origin main --force

echo "################################################################"
echo "###################    cleanup  Done      ######################"
echo "################################################################"

echo
tput setaf 3
echo "################################################################"
echo "################### DO GITLAB TOO - MANUALLY"
echo "################################################################"
tput sgr0
echo
