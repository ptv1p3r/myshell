#!/bin/bash

printf "myshell> "

# get commands
read commands #reads full line
read -r command options <<< "$commands" #IFS slipt commands
#echo $command
#echo $options

# display freespace of device
getFreespace(){
	df -h /dev/sda1
}

#display pid of process in ascending order
getPid(){
	echo "${1^}'s PID" # bash 4+ capitalize first letter
	ps aux | grep $1 | awk '{print $2}'
}

# display help for the shell
getHelp(){
	echo "Ajuda"
}

# display file permissions
getFilePermissions(){
	ls -ld $1 | awk '{ print $1; }'
}

case $command in
	pid)	getPid	$options;;	
	freespace) getFreespace ;;
	help) getHelp ;;
	permissions) getFilePermissions $options;;
	exit) printf "ISMAT SO 2020 Pedro Roldan shell exit\n" ; exit ;
esac


