#!/bin/bash
 
user=root
 
while [ "$1" != "" ];
do
	server=$1
    memory=(`ssh ${user}@${server} free | grep Mem`)
 
    freemem=${memory[3]}
    if [ ${freemem} -lt  1024000 ]
    then
        echo $server " | " $freemem
    fi

    shift
done
