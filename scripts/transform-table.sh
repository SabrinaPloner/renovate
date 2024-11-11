#!/bin/bash

awk '{print $1,$3}' grype_output.txt | tail -n +2 > tmp.txt

mkdir -p dependencies
rm -rf dependencies/*

# for each line create a new file
while read l; do
  packagename=$(echo $l | awk '{print $1}')
  fixedVersion=$(echo $l | awk '{print $2}')

  mkdir dependencies/$packagename
  touch dependencies/$packagename/versiontracker.json
  echo "$fixedVersion"  >> "dependencies/$packagename/versiontracker.json"
done <tmp.txt
rm tmp.txt

# only write highest version into file
for packagedir in dependencies/*; do
  version=$(sort $packagedir/versiontracker.json | tail -1)

done


