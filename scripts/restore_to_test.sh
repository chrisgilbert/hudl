#!/bin/bash

# Restore data to the test server and sanitize sensitive fields

TEST_HOST=test
TEST_DB=test
TEST_USER=test_user
TEST_PASS=test_password

echo Restoring DB to test.
gzip -dc /backups/prod_db_latest.sql.gz | mysql -h $TEST_HOST -u $TEST_USER --password=$TEST_PASS $TEST_DB

echo Sanitizing data.
mysql -h $TEST_HOST -u $TEST_USER --password=$TEST_PASS $TEST_DB < /scripts/sanitize_data.sql

