#!/bin/bash

script_path=$(dirname ${BASH_SOURCE[0]:-$0})

out_folder="UT_Backup_$(date +%y.%m.%d)"	#Create dated backup folder in Backups folder
out_path="$script_path/Backups/$out_folder/"

echo ""
echo "Backing up Ubuntu Touch home folders"
echo ""
echo "It is recommended to skip the .cache folder to save time"
echo ""

folder_array_1=($(adb shell ls -A -d /home/phablet/*/))				#create array of folders contained in the devices home folder
folder_array_2=($(adb shell ls -A -d /home/phablet/.*[A-Za-z]/))	#create array of hidden folders contained in the devices home folder

echo "Please make sure your device is in Developer mode and connected via USB before proceeding"
read -p "Would you like to start backing up your devices home folder? [Y/N] " -n 1 -r
echo ""
if [[ "$REPLY" =~ ^[Yy]$ ]]
then
	echo ""
	echo "Device backup starting............................."
	echo ""
	echo "Creating $out_path"
	echo ""
	mkdir -p "$out_path"				#Create backup dated backup folder
else
	echo ""
	echo "Goodbye"
	exit 1
fi

for folder in ${folder_array_1[@]}
do
	read -p "Would you like to backup $folder`echo $'\n[Y/N] '`" -n 1 -r
	echo ""
	
	if [[ "$REPLY" =~ ^[Yy]$ ]]
	then
		adb pull "$folder" "$out_path"
		echo ""
	else
		echo "Skipping $folder"
		echo ""
	fi
done

for folder in ${folder_array_2[@]}
do
	read -p "Would you like to backup $folder`echo $'\n[Y/N] '`" -n 1 -r
	echo ""

	if [[ "$REPLY" =~ ^[Yy]$ ]]
	then
		adb pull "$folder" "$out_path"
		echo ""
	else
		echo "Skipping $folder"
		echo ""
	fi
done

echo "$out_folder complete"
echo "Run UT_Restore_Tool.sh and follow the prompts to restore the folders"
