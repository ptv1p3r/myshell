#!/bin/bash

EXIT_SHELL=false

# display freespace of device
getFreespace(){
	df -h /dev/sda1
}

# display pid of process in ascending order
getPid(){
	echo "${1^}'s PID" # bash 4+ capitalize first letter
	ps aux | grep $1 | awk '{print $2}'
}

# display help for the shell
getHelp(){
	printf "MyShell Help Commands 1.0\n"
	printf 	"pid\tGet process PID ex:pid firefox\n"
	printf	"freespace\tDisplay device used space\n"
	printf	"permissions\tDisplay file permissions\n"
	printf	"bakmove\tMove file and create backup\n"
	printf	"exit\tExit myshell\n"
}

# display file permissions
getFilePermissions(){
	ls -ld $1 | awk '{print $1;}'
}


# moves file to destination and makes bakcup
moveFileWithBackup(){
	#echo $1
	#echo $2
	filename="${1##*/}" 
	extension="${filename##*.}"
	#extension=$([[ "$filename" = *.* ]] && echo ".${filename##*.}" || echo '')
	filename="${filename%.*}"
	echo $filename
	echo $extension
}

# executes normal bash commands
executeBash(){
	$1 $2	
}

# exit myshell
exitBash(){
	EXIT_SHELL=true
	printf "ISMAT SO 2020 Pedro Roldan shell 1.0 exit\n"

}

#control structure
until [ "$EXIT_SHELL" = true ]; do
	printf "myshell> "

	# get commands
	read commands #reads full line
	read -r command options <<< "$commands" #IFS slipt commands
	#echo $command
	#echo $options
	
	case $command in
		pid) getPid	$options;;	
		freespace) getFreespace;;
		help) getHelp;;
		permissions) getFilePermissions $options;;
		bakmove) moveFileWithBackup $options;;
		#exit) printf "ISMAT SO 2020 Pedro Roldan shell exit\n"; exit;;
		exit) exitBash;;
		*) executeBash $command $options;;
	esac
done

