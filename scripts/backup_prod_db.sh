#!/bin/bash

# Backup the prod db and remove previous copy on success

mysqldump -u root --add-drop-table prod | gzip -c  > /backups/prod_db_new.sql.gz


if [ $? -eq 0 ]; then
  mv /backups/prod_db_new.sql.gz /backups/prod_db_latest.sql.gz
else 
  echo Backup failed!
  exit 1
fi
  
