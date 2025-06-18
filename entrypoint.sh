#!/bin/bash
set -e

# Create necessary directories
mkdir -p /mlflow/data/artifacts
mkdir -p /mlflow/runs

# Initialize SQLite DB if not exists
if [ ! -f "/mlflow/data/mlflow.db" ]; then
    echo "Initializing SQLite database..."
    sqlite3 /mlflow/data/mlflow.db "VACUUM;"
fi

# Set permissions
chmod -R 777 /mlflow

echo "Starting MLflow server..."
exec mlflow server \
    --backend-store-uri "${MLFLOW_TRACKING_URI}" \
    --default-artifact-root "${MLFLOW_DEFAULT_ARTIFACT_ROOT}" \
    --host 0.0.0.0 \
    --port 5000