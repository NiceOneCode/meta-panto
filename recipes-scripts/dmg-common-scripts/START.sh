#!/bin/bash

PID=0
function piddeath_wait()
{
	while [ -e /proc/$PID ]
  do
            sleep 5
            echo "ciclo pid"
						cat "/sys/kernel/dmg/dmgadcmanager/timerstatus" >> "/home/root/TimerMon.txt"
	done
  return 0
}

function zipper()
{
	cd /mnt
	for directory in ./*/
	do
		if [ -d $directory ];
			then
				cd "$directory"
				numfile=$(ls *.$1 2>/dev/null | wc -l )
					if [ $numfile != 0 ];
						then
						echo ;
						echo "zipping .$1 in $directory"
						zip -r ${PWD##*/}_$1.zip *.$1

						filezipped=${PWD##*/}_$1
						datafile=$(date +%F_%R)

						mv $filezipped.zip ${datafile}_${filezipped}.zip

						rm ."$directory"/*.$1
					fi

				cd ..
		fi
	done
	cd
}

#if [ $ZIP_ON == 1 ];
#then
	# STARTTIME=$(date +%s)
	# echo "zipping .log and .fft files in /mnt"
	# zipper log
	# zipper fft
	# ENDTIME=$(date +%s)
	# echo "It takes $(($ENDTIME - $STARTTIME)) seconds to complete this task..."
#fi

if [ -e "/home/root/panto" ];
then
	(nice -n 10  /home/root/./panto )&
	PID=$!
	piddeath_wait
	echo "0" > /dev/dmg/halt_request
	sleep 1
	echo "0" > /dev/dmg/halt_request
	sleep 1
	echo "0" > /dev/dmg/halt_request
	sleep 1
	sync
	sync
	halt
else
	echo "@DMG Application Panto not found "
fi


exit 0
