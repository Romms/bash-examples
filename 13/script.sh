#!/bin/bash

ERROR=false

cd /tmp/

IPaddresses=(
	192.168.1.1 
	192.168.1.2
	10.1.10.101
	10.1.10.102
	10.1.10.103
	10.1.10.104
	10.1.10.105
)

for ip in "${IPaddresses[@]}"
do
    filename=.unreachable.$ip

    ping -W 2 -c 3 "${ip}" &> /dev/null && {
        if [ -f "$filename" ]; then
            echo "WiFi Spot $ip is Reachable."
        fi

        rm -f "$filename"
    } || {
        ERROR=true
        echo "WiFi Spot $ip is unreachable."

        if [ ! -f "$filename" ]; then
            echo "$ip" > "$filename"
        fi
    }
done

if [ "$ERROR" = true ] ; then
	exit 1
else
	exit 0
fi