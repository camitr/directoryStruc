#!/bin/bash

while IFS=, read -ra arr; do

	echo ${arr[6]}

	echo " INSERT into path_detail (path,level,size,day,month,time) values ('${arr[0]}','${arr[1]}','${arr[2]}','${arr[3]}','${arr[4]}','${arr[5]}');"

done <final1 |  mysql -uroot -p123 dirstruc
