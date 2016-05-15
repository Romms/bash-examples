#!/bin/bash
lockfile=/tmp/script.lock

# body
sleep 1

echo `date` " - Process finished"
rm -f $lockfile