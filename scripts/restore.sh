#!/bin/bash
# MLflow Data Restore Script for Jetson Nano

set -e  # Exit on error

# Validate arguments
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <backup_directory>"
    echo "Available backups:"
    ls -1 ./backups/ 2>/dev/null || echo "No backups found"
    exit 1
fi

BACKUP_SOURCE="$1"
TARGET_DIR="./data"

# Verify backup exists
if [ ! -d "$BACKUP_SOURCE" ]; then
    echo "Error: Backup directory not found at $BACKUP_SOURCE"
    exit 1
fi

# Stop MLflow container if running
if docker ps | grep -q mlflow_server; then
    echo "Stopping running MLflow container..."
    docker stop mlflow_server
fi

# Clean existing data (with confirmation)
read -p "This will overwrite existing MLflow data. Continue? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
fi

echo "Restoring data from $BACKUP_SOURCE..."
rm -rf "${TARGET_DIR:?}/"*  # Safely clear target
cp -r "$BACKUP_SOURCE/"* "$TARGET_DIR/"

# Fix permissions (important for Docker)
chmod -R a+rw "$TARGET_DIR"

# Restart container
echo "Starting MLflow server..."
docker-compose up -d

echo "Restore complete! MLflow running with data from $(basename "$BACKUP_SOURCE")"