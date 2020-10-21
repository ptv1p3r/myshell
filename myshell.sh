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

case $command in
	pid)	getPid	$options;;	
	freespace) getFreespace ;;
	help) getHelp ;;
	exit) printf "Pedro Roldan shell exit\n" ; exit ;
esac


