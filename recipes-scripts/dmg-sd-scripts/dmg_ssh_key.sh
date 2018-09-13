#!/bin/sh

LOG=1

DEF_BASE_PATH="etc/ssh"
DEF_CONFIG_PATH=".config"
DEF_KEYS_PATH=".config_keys"

REQUESTED_ACTION=0

MD5VALUE_GET=""

if [ ! -n "$1" ]
then
	echo "$0: No argument supplied"
	echo "$0: dmg_sshkeys.sh <absolute path sshkeys file> <command>"
	exit 100
fi

if [ ! -n "$2" ]
then
	echo "$0: command missing"
	exit 101
fi

if [ "$2" = "-w" ]
then
	REQUESTED_ACTION=1
fi

INFILE=$1


function CheckDir() {
	if [ ! -d "/${DEF_BASE_PATH}" ]
	then
		exit 1
	fi

	cd "/${DEF_BASE_PATH}"

	if [ ! -d "$DEF_CONFIG_PATH" ]
	then
		mkdir "$DEF_CONFIG_PATH"
	fi

	cd "$DEF_CONFIG_PATH"

	if [ ! -d "$DEF_KEYS_PATH" ]
	then
		mkdir "$DEF_KEYS_PATH"
	fi

	cd "$DEF_KEYS_PATH"
}


function CheckMd5() {
	if [ ! -e "$INFILE" ]
	then
		return 1
	fi

	IPK_FILE_NAME=`basename $INFILE`
	
	if [ $LOG -eq 1 ]
	then
		echo $IPK_FILE_NAME
	fi

	MD5VALUE_Source=( $(md5sum ${INFILE}) )

	if [ $LOG -eq 1 ]
	then
		echo $MD5VALUE_Source
	fi

	NEWNAME="${IPK_FILE_NAME}.m5v"

	if [ ! -e $NEWNAME ]
	then
		return 2
	fi

	MD5VALUE_GET=$(cat $NEWNAME)

	if [ "$MD5VALUE_GET" = "$MD5VALUE_Source" ]
	then
		return 0
	fi

	return 3
}

function storeMd5() {
	if [ ! -e "$INFILE" ]
	then
		return 1
	fi

	IPK_FILE_NAME=`basename $INFILE`
	
	if [ $LOG -eq 1 ]
	then
		echo $IPK_FILE_NAME
	fi

	MD5VALUE_Source=( $(md5sum ${INFILE}) )

	if [ $LOG -eq 1 ]
	then
		echo $MD5VALUE_Source
	fi

	NEWNAME="${IPK_FILE_NAME}.m5v"

	if [ -e $NEWNAME ]
	then
		rm -f $NEWNAME
	fi

	echo $MD5VALUE_Source > $NEWNAME
	sync
	sync
	sync

	return 0
}



main() {
	CheckDir

	if [ $REQUESTED_ACTION -eq 1 ]
	then
		storeMd5
	fi

	CheckMd5

	exit $?
}

main
