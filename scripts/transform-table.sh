#!/bin/bash

awk '{print $1,$3}' grype_output.txt | tail -n +2 > tmp.txt

mkdir -p packages
rm -rf packages/*



# for each line create a new file
while read l; do
  packagename=$(echo $l | awk '{print $1}')
  fixedVersion=$(echo $l | awk '{print $2}')

  mkdir packages/$packagename
  touch packages/$packagename/versiontracker.json
  echo "$fixedVersion"  >> "packages/$packagename/versiontracker.json"
done <tmp.txt
rm tmp.txt

# only write highest version into file
for packagedir in packages/*; do
  version=$(sort $packagedir/versiontracker.json | tail -1)

  echo "[{\"version\": \"$version\",\"filelink\": \"https://repo1.maven.org/maven2/junit/junit/4.13.1/junit-4.13.1.pom\"}]" > $packagedir/versiontracker.json
done



