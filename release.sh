#!/bin/sh
if [ $# != 1 ]; then
  echo Usage: ./release.sh 1.2.3
  exit 1
fi

set -ex
new_version="$1"
sed -i 's/"version": ".*"/"version": "'$new_version'"/' package.json
npm i
git commit -am "Release $new_version"
git tag -a v$new_version -m "vscode-lean $new_version"
./node_modules/.bin/vsce publish
git push
git push --tags
