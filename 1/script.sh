#!/bin/bash

user=$1

homedir=`grep -e "^$user" "/etc/passwd" | cut -d: -f6`
echo "$homedir"

