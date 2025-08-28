#!/bin/bash

if [ -z "$1" ]; then
    echo "Error: No table name provided."
    echo "Usage: $0 <table_name>"
    exit 1
fi

TABLE_NAME="$1"

# # Check if ~/.my.cnf exists
# if [ ! -f "$HOME/.cnf" ]; then
#     echo " No ~/.cnf file found. Let's create one now."
    
#     read -p "Enter MySQL username: " USER_NAME
#     read -s -p "Enter MySQL password: " USER_PASSWORD
#     echo
#     read -p "Enter MySQL host (default: localhost): " HOST_NAME
#     MYSQL_HOST=${MYSQL_HOST:-localhost}
    
#     cat > "$HOME/.my.cnf" <<EOF
# [client]
# user=$USER_NAME
# password=$USER_PASSWORD
# host=$HOST_NAME
# EOF

#     chmod 666 "$HOME/.my.cnf"
#     echo "~/.my.cnf created successfully."
# else
#     echo "file is already there ~/.my.cnf"
# fi

USER_NAME="sudarshan"

USER_PASSWORD="12345"

HOST_NAME="localhost"

DATABASE_NAME="cinema"

DATE=$(date +"%Y-%m-%d_%H-%M-%S")

BACKUP_DIR="/home/ncs/sudarshan/backup/${DATABASE_NAME}"
BACKUP_FILE="${BACKUP_DIR}/${TABLE_NAME}_${DATE}.sql.gz"

mkdir -p "$BACKUP_DIR"
TABLE_EXISTS=$(mysql -u "$USER_NAME" -p"$USER_PASSWORD" -h "$HOST_NAME" -N -s -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = '$DATABASE_NAME' AND table_name = '$TABLE_NAME';" 2>/dev/null)
if [[ "$TABLE_EXISTS" =~ ^[0-9]+$ && "$TABLE_EXISTS" -eq 1 ]]; then
echo "Table "$TABLE_NAME" exists. Starting dump..."

# Perform the mysqldump and compress
    if mysqldump -u" $USER_NAME" -p"$USER_PASSWORD" -h "$HOST_NAME" "$DATABASE_NAME" "$TABLE_NAME" | gzip > "$BACKUP_FILE"; then
        echo "Dump of table '$TABLE_NAME' saved to '$BACKUP_FILE'."
    else
        echo "Error: mysqldump failed for table '$TABLE_NAME'."
        exit 1
    fi
else
    echo " Error: Table '$TABLE_NAME' does not exist in database '$DATABASE_NAME' or access failed."
    exit 1
fi
exit 0