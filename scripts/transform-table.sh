#!/bin/bash

awk '{print $1,$3}' grype_output.txt | tail -n +2 > tmp.txt

mkdir -p packages
rm -f packages/*

# for each line create a new file
while read l; do
  packagename=$(echo $l | awk '{print $1}')
  fixedVersion=$(echo $l | awk '{print $2}')

  touch packages/$packagename
  echo "$fixedVersion"  >> "packages/$packagename"
done <tmp.txt
rm tmp.txt

# only write highest version into file
for file in packages/*; do
  echo $(sort $file | tail -1) > $file
done



