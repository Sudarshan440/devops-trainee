#!/bin/bash

USER_NAME="sudarshan"
PASSWORD="12345" 
HOST_NAME="localhost"
BACKUP_BASE_DIR="/home/ncs/sudarshan/backup"

usage() {
    echo "Usage:"
    echo "  $0 table <db_name> <table_name>"
    echo "  $0 full <db_name>"
    echo "  $0 schema <db_name> [table_name]"
    echo "  $0 all"
    echo "  $0 help"
    exit 1
}

# Check for at least one argument
if [ $# -lt 1 ]; then
    usage
fi

COMMAND=$1
DATE=$(date +"%Y-%m-%d_%H-%M-%S")

case "$COMMAND" in
    table)
        if [ $# -ne 3 ]; then usage; fi
        DATABASE_NAME=$2
        TABLE_NAME=$3
        BACKUP_DIR="${BACKUP_BASE_DIR}/${DATABASE_NAME}"
        BACKUP_FILE="${BACKUP_DIR}/${TABLE_NAME}_${DATE}.sql"
        mkdir -p "$BACKUP_DIR"
        mysqldump -u "$USER_NAME" -p"$PASSWORD" -h "$HOST_NAME" "$DATABASE_NAME" "$TABLE_NAME" > "$BACKUP_FILE"
        ;;
    
    full)
        if [ $# -ne 2 ]; then usage; fi
        DATABASE_NAME=$2
        BACKUP_DIR="${BACKUP_BASE_DIR}/${DATABASE_NAME}"
        BACKUP_FILE="${BACKUP_DIR}/${DATABASE_NAME}_full_${DATE}.sql"
        mkdir -p "$BACKUP_DIR"
        mysqldump -u "$USER_NAME" -p"$PASSWORD" -h "$HOST_NAME" "$DATABASE_NAME" > "$BACKUP_FILE"
        ;;
    
    schema)
        if [ $# -lt 2 ]; then usage; fi
        DATABASE_NAME=$2
        TABLE_NAME=$3  # optional
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
    
    help|--help|-h)
        usage
        ;;
    
    *)
        echo "Invalid option: $COMMAND"
        usage
        ;;
esac

# Result status
if [ $? -eq 0 ]; then
    echo " Backup completed successfully: $BACKUP_FILE"
else
    echo " Backup failed!"
    exit 1
fi
