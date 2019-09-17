#!/bin/bash

#IMPORTANT!!!Please Setting the following Values!

Backup_Home="/backup/"
MySQL_Dump="/usr/local/mysql/bin/mysqldump"

######~Set MySQL Database you want to backup~######
Backup_Database=("my_sharp""th_sharp" )

######~Set MySQL UserName and password~######
MYSQL_UserName='root'
MYSQL_PassWord='SP-root123!@#'


#Values Setting END!

TodayDBBackup=db-*-$(date +"%Y%m%d").sql
OldDBBackup=db-*-$(date -d -5day +"%Y%m%d").sql

Backup_Sql()
{
    ${MySQL_Dump} -u$MYSQL_UserName -p$MYSQL_PassWord $1 > ${Backup_Home}db-$1-$(date +"%Y%m%d").sql
}

if [ ! -f ${MySQL_Dump} ]; then  
    echo "mysqldump command not found.please check your setting."
    exit 1
fi


echo "Backup Databases..."
for db in ${Backup_Database[@]};do
    Backup_Sql ${db}
done

echo "Delete old backup files..."
#rm -f ${Backup_Home}${OldWWWBackup}
rm -f ${Backup_Home}${OldDBBackup}


echo "complete."