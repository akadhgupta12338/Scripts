#!/bin/bash
echo "You have to provide the path, start date and the end date"
echo

echo "Enter the path to start search"
read fpath
	if [ ! -d "$fpath" ]
	then
	    echo "Directory $fpath  DOES NOT exists." 
	    exit 1
	fi

isValidDate() {
    local d="$1"
    date "+%Y-%m-%d" -d "$d" > /dev/null  2>&1
    if [ $? != 0 ]
    then
        echo "Entered date $d is NOT a valid YYYYMMDD date"
        exit 1
    fi
}

echo "Please enter the start date in the format YYYYMMDD"
read strtdt
isValidDate $strtdt

echo "please enter the end date in the format YYYYMMDD"
read enddt
isValidDate $enddt
	if [[ "$enddt" < "$strtdt" ]]
	then
	   echo "End date can not be smaller than start date."
	   exit 1
	fi

touch -t ${strtdt}0000 /tmp/newerstart
touch -t ${enddt}2359 /tmp/newerend
 echo "+-------------------------------------------------------------+"
echo "Below are the list of files as per directory and dates entered "
echo "+--------------------------------------------------------------+"
#find ./ \( -newer /tmp/newerstart -a \! -newer /tmp/newerend \) -print
find $fpath \( -newer /tmp/newerstart -a \! -newer /tmp/newerend \) -exec ls -l {} \;


