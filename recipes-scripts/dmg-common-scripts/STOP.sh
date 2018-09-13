#!/bin/bash

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

killall   START.sh
killall   qt-diner

echo 0 > /sys/kernel/dmg/dmgadcmanager/state

echo "request Panto Stop. Wait"

for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
do
   echo -e "$i/15 ."
   sleep 1
done
exit 0



STARTTIME=$(date +%s)
echo "zipping .log and .fft files in /mnt"
zipper log
zipper fft
ENDTIME=$(date +%s)
echo "It takes $(($ENDTIME - $STARTTIME)) seconds to complete this task..."

exit 0
