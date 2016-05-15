#!/bin/bash
lockfile=/tmp/script.lock
script=./script2.sh 
timelimit=13

rm -f $lockfile
 
while [ 1 -gt 0 ]
do
    if [ ! -e $lockfile ];then
        echo `date` > $lockfile

		echo `date` " - Process started"

        $script &
    fi

    sleep $timelimit
done