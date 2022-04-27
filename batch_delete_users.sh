#!/bin/bash

dir=`dirname $0`
source_file="$dir/users_list.txt"

keyflag=0

iter_num=1
if [ $# -ne 0 ];then
case "$1" in
-b) keyflag=1;;
*) echo "$1 is not incorrect key"
   exit 1;;
esac
fi

for user_data in $(cat "$source_file"); do

login=$(echo "$user_data" | awk -F ',' {'print $1'})
password=$(echo "$user_data" | awk -F ',' {'print $2'})

echo "Delete user with login: $login..."

if [ $keyflag -eq 1 ];then
cd /home/
    if [ $iter_num -eq 1 ];then
    tar -cf /opt/backup.tar $login
    else
    tar -rf /opt/backup.tar $login
    fi
fi

deluser --remove-home "$login" &>>/dev/null

if [ $? -ne 0 ];then
echo "error: User does not exist"
else
echo "done"
fi

#[ $iter_num -eq 3 ]&& exit 8
#iter_num=$(($iter_num+1))

iter_num=$(($iter_num+1))

done

gzip /opt/backup.tar
