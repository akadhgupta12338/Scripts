#!/bin/bash
while getopts :d:s:e: OPTION
do
  case ${OPTION} in
    d)
     dir=${OPTARG}
     echo "Directory is $dir"
     if [ ! -d "$dir" ]
        then
            echo "Directory $dir  DOES NOT exists."
            exit 1
        fi
     ;;
    s)
     strtdt=${OPTARG}
     echo "Start date is $strtdt. " 
     date "+%Y-%m-%d" -d "$strtdt" > /dev/null  2>&1
      if [ $? != 0 ]
       then
           echo "Entered date $strtdt is NOT a valid YYYYMMDD date"
        exit 1
      fi
     ;;
    e)
     enddt=${OPTARG}
     echo "End date is $enddt. "
     date "+%Y-%m-%d" -d "$enddt" > /dev/null  2>&1
      if [ $? != 0 ]
      then
           echo "Entered date $enddt is NOT a valid YYYYMMDD date"
      elif [[ "$enddt" < "$strtdt" ]]
      then
           echo "End date can not be smaller than start date."
        exit 1
      fi
     ;;

  esac
done

touch -t ${strtdt}0000 /tmp/newerstart
touch -t ${enddt}2359 /tmp/newerend
echo "+------------------------------------------------------------------+"
echo "Below are the list of files as per directory and dates entered "
echo "+------------------------------------------------------------------+"
#find ./ \( -newer /tmp/newerstart -a \! -newer /tmp/newerend \) -print
find $dir \( -newer /tmp/newerstart -a \! -newer /tmp/newerend \) -exec ls -l {} \;
