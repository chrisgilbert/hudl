#!/bin/bash

# Restore data to the dev server and sanitize sensitive fields


mysql -h dev_host -u dev_user -p password1 dev_db < /backups/latest.sql

mysql -u dev_host dev_user -p password1 dev_db  < /scripts/sanitize_data.sql

