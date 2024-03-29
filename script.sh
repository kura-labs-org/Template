#!/bin/bash

fileNum=$(find ./branchA -type f | wc -l)

if [[ $fileNum == 5 ]]
then
  echo "Loading Script"
else
  echo "Please create 5 files in branchA"
  exit 1
fi

if [[ -d ./branchA ]]
then
 echo "Creating CorpFolder"
 mkdir ./CorpFolder && mkdir ./CorpFolder/DevTeam && mkdir ./CorpFolder/DataTeam && mkdir ./CorpFolder/OpTeam
 touch ./CorpFolder/DevTeam/file_{A..Z} && touch ./CorpFolder/DataTeam/file_{A..Z} && touch ./CorpFolder/OpTeam/file_{A..Z}
else
  echo "Please run the script in the Desktop Directory and you've already created 5 files in the branchA directory"
  exit 1
fi
