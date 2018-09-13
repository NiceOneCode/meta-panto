#!/bin/sh

LOG=1

LOG_SSH_START="/tmp/sshstart.log"
LOG_SSH_STATUS="/tmp/sshstatus.log"
LOG_SSH_SCRIPT="/tmp/sshscript.log"

SSH_ALREADY=" is already running"

SSH_RUNNING=" is running..."

SSH_STATUS="1"


MAXVAL=9

PARAMETRI=$#
PRIMO=$1

function controllo() {
	local parameters=$PARAMETRI
	local first=$PRIMO
	local index=9

	echo " quanti sono $parameters" >> ${LOG_SSH_SCRIPT}

	if [  $parameters -ne 0 ]
	then
		echo " ci passo ???? $first" >> ${LOG_SSH_SCRIPT}
		echo $first | grep -q "^[0-9]"
		if [ $? -eq 0 ] ;
		then
			index=$first
		else
			index=1
		fi
	fi

	echo " quanto vale index: $index" >> ${LOG_SSH_SCRIPT}

	return $index
}


function TestSSHisSTART() {
	out=0

	if [ -e "$LOG_SSH_START" ]
	then
		rm -f $LOG_SSH_START
		echo "$LOG_SSH_START clear" >> ${LOG_SSH_SCRIPT}
	fi

	/etc/init.d/sshd start >> $LOG_SSH_START

	if [ ! -e "$LOG_SSH_START" ]
	then
		echo "!!!!!!!!!!!!!!!!!!!!!!! CHECK OFFICIAL SSH START  !!!!!!!!!!!!!!!!!!!!!!!!!" >> ${LOG_SSH_SCRIPT}
		echo "---------------------------------------------------------------------------" >> ${LOG_SSH_SCRIPT}
		echo ">>  Image file: /tmp/sshstart.log not found                              <<" >> ${LOG_SSH_SCRIPT}
		echo "---------------------------------------------------------------------------" >> ${LOG_SSH_SCRIPT}
		out=-2
		echo ${out} >> ${LOG_SSH_SCRIPT}
		exit -2
	fi

	if [ $LOG -eq 1 ]
	then
		echo ${out} >> ${LOG_SSH_SCRIPT}
	fi

	return 0
}


function TestSSHStatus() {
	out=0
	if [ -e "$LOG_SSH_STATUS" ]
	then
		rm -f $LOG_SSH_STATUS
		echo "$LOG_SSH_STATUS clear" >> ${LOG_SSH_SCRIPT}
	fi

	/etc/init.d/sshd status >> $LOG_SSH_STATUS

	if [ ! -e "$LOG_SSH_STATUS" ]
	then
		echo "!!!!!!!!!!!!!!!!!!!!!!! CHECK OFFICIAL SSH STATUS !!!!!!!!!!!!!!!!!!!!!!!!!" >> ${LOG_SSH_SCRIPT}
		echo "---------------------------------------------------------------------------" >> ${LOG_SSH_SCRIPT}
		echo ">>  Image file: /tmp/sshstatus.log not found                             <<" >> ${LOG_SSH_SCRIPT}
		echo "---------------------------------------------------------------------------" >> ${LOG_SSH_SCRIPT}
		out=-2
		echo ${out} >> ${LOG_SSH_SCRIPT}
		exit -2
	fi

	if [ $LOG -eq 1 ]
	then
		echo ${out} >> ${LOG_SSH_SCRIPT}
	fi

	return 0
}

function isSSHstartOK() {
	out=1

	linecnt=$(cat $LOG_SSH_START | wc -l )

	if [ $linecnt -ne 0 ]
	then 
		while IFS='' read -r line || [[ -n "$line" ]]; do
			echo "Text read from file: $line" >> ${LOG_SSH_SCRIPT}
			if [[ $line = *"$SSH_ALREADY"* ]]
			then
				out=0
				echo "It's there!" >> ${LOG_SSH_SCRIPT}
				return $out
			fi
		done < "$LOG_SSH_START"
	fi

	return $out
}

function isSSHstatusOK() {
	out=1
	linescnt=$(cat $LOG_SSH_STATUS | wc -l )

	if [ $linescnt -ne 0 ]
	then
		while IFS='' read -r line || [[ -n "$line" ]]; do
			echo "Text read from file: $line" >> ${LOG_SSH_SCRIPT}
			if [[ $line = *"$SSH_RUNNING"* ]]
			then
				out=0
				echo "It's there!" >> ${LOG_SSH_SCRIPT}
				return $out
			fi
		done < "$LOG_SSH_STATUS"
	fi

	return $out
}

function recallme()
{
	controllo                                 

	local ki=$?

	echo " My instance is $ki " >> ${LOG_SSH_SCRIPT}
	
	if [ $ki -lt $MAXVAL ]
	then
		sum=$(($ki+1))
		echo " Auto ReRUN with $sum" >> ${LOG_SSH_SCRIPT}
		./etc/init.d/dmg_ssh_check.sh "${sum}" &
	fi

	exit 0
}

function RestoreSSH() {
	rm -f /etc/ssh/ssh_host_*

	/etc/init.d/sshd start
	sync
	sync

	sleep 5

	check_or_store_Integrity "-w"

	recallme
}

function check_or_store_Integrity() {
	local DEF_SSH_PATH="/etc/ssh"
	local DEF_BASE_NAME="ssh_host_*"
	local CORRUPTION=0
	local KEY_LS="${DEF_SSH_PATH}/${DEF_BASE_NAME}"
	local array=( $(ls $KEY_LS ) )

	for f in ${array[@]}
	do
		echo " file is $f" >> ${LOG_SSH_SCRIPT}
		sh /etc/init.d/dmg_ssh_key.sh "${f}" "$1" >> ${LOG_SSH_SCRIPT}
		if [ $? -ne 0 ]
		then
			CORRUPTION=1
		fi
	done

	return $CORRUPTION
}

main()
{
	echo -n "Running the DMG SSH check ... "

	if [ -e "${LOG_SSH_SCRIPT}" ]
	then
		rm -f ${LOG_SSH_SCRIPT}
		echo "$LOG_SSH_SCRIPT clear" >> ${LOG_SSH_SCRIPT}
	fi

	echo "###########################################################################" >> ${LOG_SSH_SCRIPT}
	echo "#   START SCRIPT DMG_SSH_CHECK                                            #" >> ${LOG_SSH_SCRIPT}
	echo "###########################################################################" >> ${LOG_SSH_SCRIPT}
	echo "###########################################################################" >> ${LOG_SSH_SCRIPT}
	echo "#   START TestSSHStatus                                                   #" >> ${LOG_SSH_SCRIPT}
	echo "###########################################################################" >> ${LOG_SSH_SCRIPT}
	TestSSHStatus

	echo "###########################################################################" >> ${LOG_SSH_SCRIPT}
	echo "#   START isSSHstatusOK                                                   #" >> ${LOG_SSH_SCRIPT}
	echo "###########################################################################" >> ${LOG_SSH_SCRIPT}
	isSSHstatusOK
	retval=$?

	echo "RETVAL of isSSHstatusOK is $retval" >> ${LOG_SSH_SCRIPT}

	if [ $retval -eq 1 ]
	then
		echo "###########################################################################" >> ${LOG_SSH_SCRIPT}
		echo "#   START RestoreSSH              exit 1                                  #" >> ${LOG_SSH_SCRIPT}
		echo "###########################################################################" >> ${LOG_SSH_SCRIPT}
		RestoreSSH
		echo "failed"
		exit 1
	fi

	echo "###########################################################################" >> ${LOG_SSH_SCRIPT}
	echo "#   START TestSSHisSTART                                                  #" >> ${LOG_SSH_SCRIPT}
	echo "###########################################################################" >> ${LOG_SSH_SCRIPT}
	TestSSHisSTART

	echo "###########################################################################" >> ${LOG_SSH_SCRIPT}
	echo "#   START isSSHstartOK                                                    #" >> ${LOG_SSH_SCRIPT}
	echo "###########################################################################" >> ${LOG_SSH_SCRIPT}
	isSSHstartOK
	retval1=$?
	echo " RETVAL isSSHstartOK is  $retval1" >> ${LOG_SSH_SCRIPT}

	if [ $retval1 -eq 1 ]
	then
		echo "###########################################################################" >> ${LOG_SSH_SCRIPT}
		echo "#   START RestoreSSH      exit 2                                          #" >> ${LOG_SSH_SCRIPT}
		echo "###########################################################################" >> ${LOG_SSH_SCRIPT}
		RestoreSSH
		echo "failed"
		exit 2
	fi

	echo "###########################################################################" >> ${LOG_SSH_SCRIPT}
	echo "#   START check_or_store_Integrity                                        #" >> ${LOG_SSH_SCRIPT}
	echo "###########################################################################" >> ${LOG_SSH_SCRIPT}
	check_or_store_Integrity "-c"
	retval2=$?
	echo " RETVAL check_or_store_Integrity is  $retval2" >> ${LOG_SSH_SCRIPT}

	if [ $retval2 -eq 0 ]
	then
		echo "###########################################################################" >> ${LOG_SSH_SCRIPT}
		echo "#              exit 0                                                     #" >> ${LOG_SSH_SCRIPT}
		echo "###########################################################################" >> ${LOG_SSH_SCRIPT}
		echo "done"
		exit 0
	fi

	echo "###########################################################################" >> ${LOG_SSH_SCRIPT}
	echo "#   START RestoreSSH      exit 3                                          #" >> ${LOG_SSH_SCRIPT}
	echo "###########################################################################" >> ${LOG_SSH_SCRIPT}
	RestoreSSH

	echo "failed"
	exit 3
}
 
main
