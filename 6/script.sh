#!/bin/bash
 
user=root
com=$1
shift

while [ "$1" != "" ]; do
  echo "${1}"
  ssh ${user}@${1} "${com}"
  shift
done;
