#!/bin/bash

# === CONFIG ===
SOURCE_DIR="$HOME/Documents/Git"
BACKUP_DIR="$HOME/Backups"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="$BACKUP_DIR/backup.log"

# === SETUP ===
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Source directory does not exist: $SOURCE_DIR"
    exit 1
fi 

if [ ! -d "$BACKUP_DIR" ]; then
    echo "Backup directory does not exist: $BACKUP_DIR"
    exit 1
fi

# === BACKUP ===
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"

tar -czf "$BACKUP_FILE" "$SOURCE_DIR"

# === LOGGING ===
echo "[$TIMESTAMP] Backup created: $BACKUP_FILE" >> "$LOG_FILE"

# === OUTPUT ===
echo "Backup complete: $BACKUP_FILE"