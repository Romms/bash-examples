#!/bin/bash

domain=$1
dnsa=$(host -t A "${domain}" | awk '{print $4}' | tr "\n" " ")

for ip in ${dnsa[*]}
do
	ping -c2 $ip > /dev/null && echo $ip is available || echo $ip is NOT available
done