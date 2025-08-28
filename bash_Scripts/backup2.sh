#!/bin/bash

USER_NAME="sudarshan"
HOST_NAME="localhost"
BACKUP_BASE_DIR="/home/ncs/sudarshan/backup"

while true; do
    echo ""
    echo "========== MySQL Backup Menu =========="
    echo "1. Backup a specific table"
    echo "2. Backup a full database"
    echo "3. Backup schema only (no data)"
    echo "4. Backup all databases"
    echo "5. Exit"
    echo "======================================="
    read -p "Enter your choice [1-5]: " CHOICE

    case $CHOICE in
        1)
            read -p "Enter database name: " DATABASE_NAME
            read -p "Enter table name: " TABLE_NAME
            DATE=$(date +"%Y-%m-%d_%H:%M:%S")
            BACKUP_DIR="${BACKUP_BASE_DIR}/${DATABASE_NAME}"
            BACKUP_FILE="${BACKUP_DIR}/${TABLE_NAME}_${DATE}.sql"
            mkdir -p "$BACKUP_DIR"
            if mysqldump -u "$USER_NAME" -p "$DATABASE_NAME" "$TABLE_NAME" -h "$HOST_NAME" > "$BACKUP_FILE" ; then
            echo "Dump of table '$TABLE_NAME' saved to '$BACKUP_FILE'."
            else
            echo "Error: mysqldump failed for table '$TABLE_NAME'."
            exit 1
            fi
            exit 0
            break
            ;;
        2)
            read -p "Enter database name: " DATABASE_NAME
            DATE=$(date +"%Y-%m-%d_%H:%M:%S")
            BACKUP_DIR="${BACKUP_BASE_DIR}/${DATABASE_NAME}"
            BACKUP_FILE="${BACKUP_DIR}/${DATABASE_NAME}_full_${DATE}.sql"
            mkdir -p "$BACKUP_DIR"
            mysqldump -u "$USER_NAME" -p "$DATABASE_NAME" -h "$HOST_NAME" > "$BACKUP_FILE"
            break
            ;;
        3)
            read -p "Enter database name: " DATABASE_NAME
            read -p "Enter table name (or leave blank for full schema): " TABLE_NAME
            DATE=$(date +"%Y-%m-%d_%H:%M:%S")
            BACKUP_DIR="${BACKUP_BASE_DIR}/${DATABASE_NAME}"
            BACKUP_FILE="${BACKUP_DIR}/${DATABASE_NAME}_schema_${DATE}.sql"
            mkdir -p "$BACKUP_DIR"
            if [ -z "$TABLE_NAME" ]; then
                mysqldump -u "$USER_NAME" -p --no-data "$DATABASE_NAME" > "$BACKUP_FILE"
            else
                mysqldump -u "$USER_NAME" -p --no-data "$DATABASE_NAME" "$TABLE_NAME" > "$BACKUP_FILE"
            fi
            break
            ;;
        4)
            DATE=$(date +"%Y-%m-%d_%H:%M:%S")
            BACKUP_DIR="${BACKUP_BASE_DIR}/all_databases"
            BACKUP_FILE="${BACKUP_DIR}/all_databases_${DATE}.sql"
            mkdir -p "$BACKUP_DIR"
            mysqldump -u "$USER_NAME" -p --all-databases > "$BACKUP_FILE"
            break
            ;;
        5)
            echo "Exiting backup script."
            exit 0
            break
            ;;
        *)
            echo "Invalid choice. Please enter a number between 1 and 5."
            ;;
    esac

    # Check if last command was successful
    if [ $? -eq 0 ]; then
        echo " Backup completed successfully: $BACKUP_FILE"
    else
        echo " Backup failed!"
    fi
done
