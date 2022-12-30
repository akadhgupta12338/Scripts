#!/bin/bash
echo "You have to provide the path, start date and the end date"
echo
echo "Enter the path to start search"
read fpath
echo "Please enter the start date in the format YYYYMMDD"
read strtdt
echo "please enter the end date in the format YYYYMMDD"
read enddt
touch -t ${strtdt}0000 /tmp/newerstart
touch -t ${enddt}2359 /tmp/newerend
#find ./ \( -newer /tmp/newerstart -a \! -newer /tmp/newerend \) -print
find $fpath \( -newer /tmp/newerstart -a \! -newer /tmp/newerend \) -exec ls -l {} \;
