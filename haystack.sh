#!/bin/bash

#Downloading the necessary packages
echo "###################Checking dependency######################"
sudo  apt install lolcat figlet
sleep 5
echo "######################All done!!!###########################"

#Printing welcome screen with color ;-)
figlet "Welcome to Needle in the Haystack" | lolcat -a -s 100
sleep 2

#Ask the user a question and store input into a variable 
read -p "enter a file name [make sure the file name ends in .txt e.g. tyrone.txt]: " filename
echo "Thank you"
echo "Wait one moment"

#Create directories and randomly place a file into a directory
mkdir $HOME/haystack && mkdir $HOME/haystack/folder{1..500}
sleep 5
touch $HOME/haystack/folder$(shuf -i 1-500 -n 1)/$filename

#Double check the creation of some directories
echo "######################Almost done###########################"
sleep 5

if [[ -d $HOME/haystack/folder1 && -d $HOME/haystack/folder100 && -d $HOME/haystack/folder500 ]];
then
    echo "#################################" | lolcat -a
    echo "#                               #" | lolcat -a
    echo "#         All Done!!!           #" | lolcat -a
    echo "#         Good Luck!!           #" | lolcat -a
    echo "#                               #" | lolcat -a
    echo "#################################" | lolcat -a
else
    echo "ERROR!! Report to instructor"
fi
