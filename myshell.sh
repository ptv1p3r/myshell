#!/bin/bash

EXIT_SHELL=false

# display freespace of device
getFreespace(){
	df -h /dev/sda1
}

# display pid of process in ascending order
getPid(){
	# check for missing commands
	if [ ! -z "$1" ]
	then
		echo "${1^}'s PID" # bash 4+ capitalize first letter
		ps aux | grep $1 | awk '{print $2}'	
	else
		printf "Missing command parameters, check help!\n"
	fi 
}

# display help for the shell
getHelp(){
	printf "MyShell Help Commands 1.0\n"
	printf 	"pid\tGet process PID ex:pid firefox\n"
	printf	"freespace\tDisplay device used space\n"
	printf	"permissions\tDisplay file permissions ex: permissions path_to_filename\n"
	printf	"bakmove\tMove file and create backup ex: bakmove path_to_file path_to_foldern\n"
	printf	"bash command\tAll bash commands allowed\n"
	printf	"exit\tExit myshell\n"
}

# display file permissions
getFilePermissions(){
	if [ ! -z "$1" ] # $1 not empty
	then 
		ls -ld $1 | awk '{print $1}'
	else
		printf "Missing command parameters, check help!\n"
	fi
}


# moves file to destination and makes bakcup
moveFileWithBackup(){
	if [ ! -z "$1" ] && [ ! -z "$2" ] # $1 $2 not empty
	then
		basedir="$(dirname "${1}")" # get dir from path (POSIX standard)
		file="$(basename "${1}")" # get file from path (POSIX standard)

		# parameter extension
		filename="${1##*/}" # get file at last /
		extension="${filename##*.}" # get extension
		filename="${filename%.*}"
	
		#echo $filename
		#echo $extension 

		# check if directory exists if not create
		[ ! -d "$2" ] && mkdir -p "$2"
	
		# create backup of file
		cp $1 $basedir"/$filename.bak"
		if [ $? -eq 0 ] # check if cp is successfull =0 error =1
		then
			printf "Backup created in $basedir/$filename.bak\n"
		fi

		# move file to destination
		mv $1 $2	
	else
		printf "Missing command parameters, check help!\n"	
	fi
}

# executes normal bash commands
executeBash(){
	# command not empty
	if [ ! -z "$1" ] 
	then 
		$1 $2
	fi
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
		exit) exitBash;;
		*) executeBash $command $options;;
	esac
done

