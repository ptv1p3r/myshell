#!/bin/bash

printf "myshell> "

# get commands
read command options

# display freespace of device
getFreespace(){
	df -h /dev/sda1
}

#display pid of process in ascending order
getPid(){
	printf "pid " $1
}

case $command in
	pid)	getPid options	;;	
	freespace) getFreespace ;;
	exit) printf "Pedro Roldan shell exit\n" ; exit ;
esac


