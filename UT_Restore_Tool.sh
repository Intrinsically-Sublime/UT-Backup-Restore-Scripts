#!/bin/bash

script_path=$(dirname ${BASH_SOURCE[0]:-$0})

backup_path_0="$script_path/Backups"

backup_array=($backup_path_0/*/)

out_folder="/home/phablet/"



backup_2_restore=""

echo ""
echo "Restore backed up Ubuntu Touch home folders"
echo ""

if [[ ! -z "$1" ]]
then
	backup_2_restore="$1"
elif [[ ! -z "${backup_array[@]}" ]]
then
	echo "Enter the number corresponding to the backup you wish to restore followed by Enter"
	cat -n < <(printf "%s\n" "${backup_array[@]}")
	read -p "Press 'Crtl C' to exit`echo $'\n> '`" -n 3 -r
	echo ""
	
	if [ -n "$REPLY" ] && (( "$REPLY" <= "${#backup_array[@]}" )) 
	then
		backup_2_restore="${backup_array[($REPLY-1)]}"
	else
		echo "No backups found or selected"
		echo "Goodbye!"
		exit 1
	fi
else
	echo "No 'Backups' folder found"
	echo "Goodbye!"
	exit 1
fi

echo "$(basename "$backup_2_restore") has been selected for restoration"
echo ""
read -p "Would you like to start restoring the home folder on your device?`echo $'\n[Y/N] '`" -n 1 -r
echo ""

if [[ "$REPLY" =~ ^[Yy]$ ]]
then
	echo "Device restoration starting............................."
	echo ""
	backup_path_1=($backup_2_restore*/)
	for folder in ${backup_path_1[@]}
	do
		read -p "Would you like to restore $out_folder`echo $'\n[Y/N] '`" -n 1 -r
		echo ""
		
		if [[ "$REPLY" =~ ^[Yy]$ ]]
		then
			adb push "$folder" "$out_folder"
			echo ""
		else
			echo "Skipping $out_folder"
			echo ""
		fi
	done
	
	backup_path_2=($backup_2_restore.*[A-Za-z]/)
	for folder in ${backup_path_2[@]}
	do
		read -p "Would you like to restore $out_folder`echo $'\n[Y/N] '`" -n 1 -r
		echo ""
		
		if [[ "$REPLY" =~ ^[Yy]$ ]]
		then
			adb push "$folder" "$out_folder"
			echo ""
		else
			echo "Skipping $out_folder"
			echo ""
		fi
	done
else
	echo "Goodbye!"
	exit 1
fi
