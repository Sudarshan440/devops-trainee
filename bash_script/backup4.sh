#!/bin/bash

USER_NAME="sudarshan"
PASSWORD="12345" 
HOST_NAME="localhost"
BACKUP_BASE_DIR="/home/ncs/sudarshan/backup"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")

usage() {
    echo "Usage:"
    echo "  $0 -c table  -d <db_name> -t <table_name>"
    echo "  $0 -c full   -d <db_name>"
    echo "  $0 -c schema -d <db_name> [-t <table_name>]"
    echo "  $0 -c all"
    echo "Options:"
    echo "  -c <command>       Command: table, full, schema, all"
    echo "  -d <db_name>       Database name"
    echo "  -t <table_name>    Table name (optional for schema)"
    echo "  -h                 Show help"
    exit 1
}

# Initialize variables
COMMAND=""
DATABASE_NAME=""
TABLE_NAME=""

# Parse options using getopts
while getopts ":c:d:t:h" opt; do
  case $opt in
    c) COMMAND="$OPTARG" ;;
    d) DATABASE_NAME="$OPTARG" ;;
    t) TABLE_NAME="$OPTARG" ;;
    h) usage ;;
    \?) echo "Invalid option: -$OPTARG" >&2; usage ;;
    :) echo "Option -$OPTARG requires an argument." >&2; usage ;;
  esac
done

# Handle commands
case "$COMMAND" in
  table)
    if [ -z "$DATABASE_NAME" ] || [ -z "$TABLE_NAME" ]; then usage; fi
    BACKUP_DIR="${BACKUP_BASE_DIR}/${DATABASE_NAME}"
    BACKUP_FILE="${BACKUP_DIR}/${TABLE_NAME}_${DATE}.sql"
    mkdir -p "$BACKUP_DIR"
    mysqldump -u "$USER_NAME" -p"$PASSWORD" -h "$HOST_NAME" "$DATABASE_NAME" "$TABLE_NAME" > "$BACKUP_FILE"
    ;;
  
  full)
    if [ -z "$DATABASE_NAME" ]; then usage; fi
    BACKUP_DIR="${BACKUP_BASE_DIR}/${DATABASE_NAME}"
    BACKUP_FILE="${BACKUP_DIR}/${DATABASE_NAME}_full_${DATE}.sql"
    mkdir -p "$BACKUP_DIR"
    mysqldump -u "$USER_NAME" -p"$PASSWORD" -h "$HOST_NAME" "$DATABASE_NAME" > "$BACKUP_FILE"
    ;;
  
  schema)
    if [ -z "$DATABASE_NAME" ]; then usage; fi
    BACKUP_DIR="${BACKUP_BASE_DIR}/${DATABASE_NAME}"
    BACKUP_FILE="${BACKUP_DIR}/${DATABASE_NAME}_schema_${DATE}.sql"
    mkdir -p "$BACKUP_DIR"
    if [ -z "$TABLE_NAME" ]; then
      mysqldump -u "$USER_NAME" -p"$PASSWORD" -h "$HOST_NAME" --no-data "$DATABASE_NAME" > "$BACKUP_FILE"
    else
      mysqldump -u "$USER_NAME" -p"$PASSWORD" -h "$HOST_NAME" --no-data "$DATABASE_NAME" "$TABLE_NAME" > "$BACKUP_FILE"
    fi
    ;;
  
  all)
    BACKUP_DIR="${BACKUP_BASE_DIR}/all_databases"
    BACKUP_FILE="${BACKUP_DIR}/all_databases_${DATE}.sql"
    mkdir -p "$BACKUP_DIR"
    mysqldump -u "$USER_NAME" -p"$PASSWORD" -h "$HOST_NAME" --all-databases > "$BACKUP_FILE"
    ;;
  
  *)
    echo "Invalid or missing command."
    usage
    ;;
esac

# Show result
if [ $? -eq 0 ]; then
  echo "Backup completed successfully: $BACKUP_FILE"
else
  echo "Backup failed!"
  exit 1
fi
