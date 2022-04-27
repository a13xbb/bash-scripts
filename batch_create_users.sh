#!/bin/bash

dir=`dirname $0`
source_file="$dir/users_list.txt"

#iter_num=1

for user_data in $(cat "$source_file"); do

login=$(echo "$user_data" | awk -F ',' {'print $1'})
password=$(echo "$user_data" | awk -F ',' {'print $2'})

echo "Create user with login: $login..."

adduser "$login" &>>/dev/null << EOF
$password
$password





Y
EOF

if [ $? -ne 0 ]; then
echo "error: User already exists"
else
echo "done"
fi

#[ $iter_num -eq 3 ]&& exit 8

#iter_num=$(($iter_num+1))

done
