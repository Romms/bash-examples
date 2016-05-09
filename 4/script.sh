#!/bin/bash
 
dir=$1
day=-`date +%d`
 
find "${dir}" -type f -mtime $day -atime +7 | xargs sed -i -e "s/test/TEST/"