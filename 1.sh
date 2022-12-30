#!/bin/bash
read -p  "Enter directory in which you want to search files " dir
echo "Directory entered is "$dir" ."
read -p "Enter start date in YYYY/MM/DD format : " sd
date -d "$sd" -I > /dev/null|| exit 1
sdate="$(date -d "$sd" +%Y/%m/%d)"
echo "Start date entered is $sdate"
read -p "Enter end date in YYYY/MM/DD format : " ed
date -d "$ed" -I > /dev/null|| exit 1
edate="$(date -d "$sd" +%Y/%m/%d)"
echo "End date entered is $sdate"

log="/home/ubuntu/script/file.log"
{
find $dir -type f -print -newermt $sdate ! -newermt $edate | ls -lh
}> $log 2>&1 
echo "Logs stored at "$log" file ."
