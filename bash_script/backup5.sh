#!/bin/bash

USER_NAME="sudarshan"
PASSWORD="12345"
HOST_NAME="localhost"
BACKUP_BASE_DIR="/home/ncs/sudarshan/backup"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")

usage() {
    echo "Usage: $(basename "$0") [-t <true|false>] [-f <true|false>] [-s <true|false>] [-a <true|false>] [-d <db_name>] [-n <table_name>] [-h]"
    echo ""
    echo "  -t <true|false>   Take table backup"
    echo "  -f <true|false>   Take full database backup"
    echo "  -s <true|false>   Take only-data backup"
    echo "  -a <true|false>   Take all-database backup"
    echo "  -d <db_name>      Database name (required for -t, -f, -s)"
    echo "  -n <table_name>   Table name (required for -t; optional for -s)"
    echo "  -h                Show thisall_databases_2025-08-2 help message"
    echo ""
    echo "Examples:"
    echo "  $(basename "$0") -t true -d mydb -n users"
    echo "  $(basename "$0") -f true -d mydb"
    echo "  $(basename "$0") -0 true -d mydb [-n users]"
    echo "  $(basename "$0") -a true"
    exit 1
}

# Default values
TABLE_BACKUP=false
FULL_BACKUP=false
DATA_ONLY_BACKUP=false
ALL_BACKUP=false
DATABASE_NAME=""
TABLE_NAME=""

RETENTION_DAYS=1

if [ ! -d "$BACKUP_BASE_DIR" ]; then
    echo "Error: Directory '$BACKUP_BASE_DIR' not found."
    exit 1
fi

echo "Starting retention cleanup in '$BACKUP_BASE_DIR'..."

# Find and delete files older than the retention period
# -type f: Only consider regular files
# -mtime +$RETENTION_DAYS: Files modified more than RETENTION_DAYS ago
# -exec rm -f {}: Execute 'rm -f' on each found file
find "$BACKUP_BASE_DIR" -type f -mtime +$RETENTION_DAYS -exec rm -f {} \;

echo "Retention cleanup completed. Files older than $RETENTION_DAYS days have been deleted."

# Parse options
while getopts ":t:f:o:a:d:n:h" opt; do
  case $opt in
    t) TABLE_BACKUP="$OPTARG" ;;
    f) FULL_BACKUP="$OPTARG" ;;
    o) DATA_ONLY_BACKUP="$OPTARG" ;;
    a) ALL_BACKUP="$OPTARG" ;;
    d) DATABASE_NAME="$OPTARG" ;;
    n) TABLE_NAME="$OPTARG" ;;
    h) usage ;;
    \?) echo "Invalid option: -$OPTARG" >&2; usage ;;
    :) echo "Option -$OPTARG requires an argument." >&2; usage ;;
  esac
done

# Run backups as per flags
# TABLE BACKUP
if [[ "$TABLE_BACKUP" == "true" ]]; then
  if [ -z "$DATABASE_NAME" ] || [ -z "$TABLE_NAME" ]; then
    echo "Error: -d and -n are required for table backup"
    usage
  fi
  BACKUP_DIR="${BACKUP_BASE_DIR}/${DATABASE_NAME}"
  BACKUP_FILE="${BACKUP_DIR}/${TABLE_NAME}_${DATE}.sql"
  mkdir -p "$BACKUP_DIR"
  mysqldump -u "$USER_NAME" -p"$PASSWORD" -h "$HOST_NAME" "$DATABASE_NAME" "$TABLE_NAME" > "$BACKUP_FILE"
fi

# FULL BACKUP
if [[ "$FULL_BACKUP" == "true" ]]; then
  if [ -z "$DATABASE_NAME" ]; then
    echo "Error: -d is required for full backup"
    usage
  fi
  BACKUP_DIR="${BACKUP_BASE_DIR}/${DATABASE_NAME}"
  BACKUP_FILE="${BACKUP_DIR}/${DATABASE_NAME}_full_${DATE}.sql"
  mkdir -p "$BACKUP_DIR"
  mysqldump -u "$USER_NAME" -p"$PASSWORD" -h "$HOST_NAME" "$DATABASE_NAME" > "$BACKUP_FILE"
fi

# DATA ONLY BACKUP
if [[ "$DATA_ONLY_BACKUP" == "true" ]]; then
  if [ -z "$DATABASE_NAME" ]; then
    echo "Error: -d is required for schema backup"
    usage
  fi
  BACKUP_DIR="${BACKUP_BASE_DIR}/${DATABASE_NAME}"
  BACKUP_FILE="${BACKUP_DIR}/${DATABASE_NAME}_schema_${DATE}.sql"
  mkdir -p "$BACKUP_DIR"
  if [ -z "$TABLE_NAME" ]; then
    mysqldump -u "$USER_NAME" -p"$PASSWORD" -h "$HOST_NAME" --no-create-info "$DATABASE_NAME" > "$BACKUP_FILE"
  else
    mysqldump -u "$USER_NAME" -p"$PASSWORD" -h "$HOST_NAME" --no-create-info "$DATABASE_NAME" "$TABLE_NAME" > "$BACKUP_FILE"
  fi
fi

# ALL DATABASE BACKUP
if [[ "$ALL_BACKUP" == "true" ]]; then
  BACKUP_DIR="${BACKUP_BASE_DIR}/all_databases"
  BACKUP_FILE="${BACKUP_DIR}/all_databases_${DATE}.sql"
  mkdir -p "$BACKUP_DIR"
  mysqldump -u "$USER_NAME" -p"$PASSWORD" -h "$HOST_NAME" --all-databases > "$BACKUP_FILE"
fi

# Final message
if [[ "$TABLE_BACKUP" == "true" || "$FULL_BACKUP" == "true" || "$DATA_ONLY_BACKUP" == "true" || "$ALL_BACKUP" == "true" ]]; then
  if [ $? -eq 0 ]; then
    echo "Backup completed successfully: $BACKUP_FILE"
  else
    echo " Backup failed!"
    exit 1
  fi
else
  echo "No backup command provided. Use -t, -f, -o, or -a with true."
  usage
fi
exit 0

# 00 12 * * 1 bash /home/ncs/paramaterised/backup.sh