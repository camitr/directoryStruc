#!/bin/bash


path=`cat dirname`

#create path sed remove trailing '/' awk print data in desired columns 
tree --dirsfirst -h -fi -DF --noreport $path| tr -d []|sed 's/\/$//'|awk  '{print $5","$1","$3","$2","$4}'> final1

#filter name of the file or directory from the path 
tree --dirsfirst -h -fi -DF --noreport $path | tr -d []|awk '{print $NF}' |tr '/' ' '|awk '{print $NF}'> name

#delelte the headline 
sed -i '1d' name


#delete the head line of the file 
sed -i '1d' final1 



#generate the leve of directory 
sed 's/[^/]//g' final1 | awk '{ print length-1 }' > level

#merge final1 level and name
paste -d ',' final1 level name |awk -F ',' '{print $1","$6","$7","$2","$3","$4","$5}' > final

#filter the parent directory name 
awk -F ',' '{print $1}' final|awk -F '/' '{print $(NF-1)}' > parent

#merge final1 level name parent, this is the final output required 
paste -d ',' final1 level name parent |awk -F ',' '{print $1","$6","$8","$7","$2","$3","$4","$5}' > final


#export to database

#loop read the file get value in array form and then run the insert the query 
while IFS=, read -ra arr; do

#	echo ${arr[2]}

	echo ' INSERT into path_detail (path,level,parent,name,size,day,month,time) values (''"'${arr[0]}'"'',"'${arr[1]}'","'${arr[2]}'","'${arr[3]}'","'${arr[4]}'","'${arr[5]}'","'${arr[6]}'","'${arr[7]}'");'

done <final |  mysql -uroot -p123 dirstruc
