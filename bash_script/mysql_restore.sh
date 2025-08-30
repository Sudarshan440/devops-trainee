#!/bin/bash
set -ex

#################################################################################################
## FULL Backup - mysql_restore.sh -f -d countries -b countries_full_2025-08-28_12-00-00.sql######
## Only Data - mysql_restore.sh -o -d countries -b countries_only_data_2025-08-28_12-00-00.sql ##

cd $(dirname $0)
. ./secrets.ini

usage() {
    echo "Usage: $(basename "$0") [-f] [-o] -d <db_name> -b <backup_filename>"
    echo ""
    echo "  -f                Restore full database backup"
    echo "  -o                Restore data-only backup"
    echo "  -d <db_name>      Target database name (required)"
    echo "  -b <filename>     Backup file name to restore (e.g., mydb_full_2025-08-28_12-00-00.sql)"
    echo "  -h                Show this help message"
    echo ""
    echo "Examples:"
    echo "  $(basename "$0") -f -d mydb -b mydb_full_2025-08-28_12-00-00.sql"
    echo "  $(basename "$0") -o -d mydb -b mydb_schema_2025-08-28_12-00-00.sql"
    exit 1
}

# Default values
FULL_RESTORE=false
DATA_ONLY_RESTORE=false
DATABASE_NAME=""
BACKUP_FILENAME=""

# Parse options
while getopts ":fod:b:h" opt; do
  case $opt in
    f) FULL_RESTORE=true ;;
    o) DATA_ONLY_RESTORE=true ;;
    d) DATABASE_NAME="$OPTARG" ;;
    b) BACKUP_FILENAME="$OPTARG" ;;
    h) usage ;;
    \?) echo "Invalid option: -$OPTARG" >&2; usage ;;
    :) echo "Option -$OPTARG requires an argument." >&2; usage ;;
  esac
done
# Backup file path
BACKUP_PATH="${BACKUP_BASE_DIR}/${DATABASE_NAME}/${BACKUP_FILENAME}"

if [ ! -f "$BACKUP_PATH" ]; then
    echo "Error: Backup file not found at: $BACKUP_PATH"
    exit 1
fi
# Validations
if [ -z "$DATABASE_NAME" ] || [ -z "$BACKUP_FILENAME" ]; then
    echo "Error: Both -d <db_name> and -b <backup_filename> are required."
    usage
fi

if [[ "$FULL_RESTORE" == false && "$DATA_ONLY_RESTORE" == false ]]; then
    echo "Error: You must specify either -f (full restore) or -o (data-only restore)."
    usage
fi

if [[ "$FULL_RESTORE" == true && "$DATA_ONLY_RESTORE" == true ]]; then
    echo "Error: You cannot use both -f and -o at the same time."
    usage
fi

# DB_EXISTS=$(mysql -u "$USER_NAME" -p"$PASSWORD" -h "$HOST_NAME" -sse "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME='${DATABASE_NAME}'")
DB_EXISTS=$(mysql -u "$USER_NAME" -p"$PASSWORD" -h "$HOST_NAME" -sse "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME='${DATABASE_NAME}'")

if [ -z "$DB_EXISTS" ]; then
    echo "Database '$DATABASE_NAME' does not exist. Creating..."
    mysql -u "$USER_NAME" -p"$PASSWORD" -h "$HOST_NAME" -e "CREATE DATABASE \`${DATABASE_NAME}\`;"
    if [ $? -ne 0 ]; then
        echo "Failed to create database."
        exit 1
    fi
else
    echo "Database '$DATABASE_NAME' already exists."
    exit 1
fi

# Restore logic
echo "Starting restore of '$BACKUP_FILENAME' into database '$DATABASE_NAME'..."

mysql -u "$USER_NAME" -p"$PASSWORD" -h "$HOST_NAME" "$DATABASE_NAME" < "$BACKUP_PATH"

if [ $? -eq 0 ]; then
    echo "Restore completed successfully."
else
    echo "Restore failed."
    exit 1
fi