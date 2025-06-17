#!/bin/bash
# Backup data volume with proper permissions

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="./backups/$TIMESTAMP"

mkdir -p "$BACKUP_DIR"
cp -rp ./data/* "$BACKUP_DIR/"  # -p preserves permissions

# Compress backup (optional)
tar -czf "$BACKUP_DIR.tar.gz" "$BACKUP_DIR" && rm -rf "$BACKUP_DIR"

echo "Backup created: $BACKUP_DIR.tar.gz"