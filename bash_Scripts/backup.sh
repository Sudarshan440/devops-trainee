#!/bin/bash
if [ "$#" -ne 2 ]; then
echo "Error: No table name provided."
echo "Usage: <database_name> <table_name>"
exit 1
fi
DATABASE_NAME=$1
TABLE_NAME=$2
USER_NAME="sudarshan"

# USER_PASSWORD="12345"

HOST_NAME="localhost"

BACKUP_DIR="/home/ncs/sudarshan/backup/${DATABASE_NAME}"
BACKUP_FILE="${BACKUP_DIR}/${TABLE_NAME}_${DATE}.sql"

# FILENAME="$DATABASE-$DATE.sql.gz"

mkdir -p "$BACKUP_DIR"

# DATABASE_NAME="cinema"

DATE=$(date +"%Y-%m-%d_%H:%M:%S")

mysqldump -u "$USER_NAME" -p "$DATABASE_NAME" -h "$HOST_NAME" > "${BACKUP_FILE}"

# Dumping all databases on the server :
# mysqldump -u "$USER_NAME" -p --all-databases > "$BACKUP_DIR/${DATABASE_NAME}_${DATE}.sql"

# Dumping only the schema of a database, without data : 
# mysqldump -u "$USER_NAME" -p --no-data "$DATABASE_NAME" > "$BACKUP_DIR/${DATABASE_NAME}_${DATE}.sql"

if [ $? -eq 0 ]; then
    echo "Backup of $DATABASE_NAME completed successfully to $BACKUP_FILE"
else
    echo "Backup of $DATABASE_NAME failed!"
fi
exit 0