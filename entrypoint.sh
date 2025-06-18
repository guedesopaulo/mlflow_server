#!/bin/bash
set -e

# Create all necessary MLflow directories (only those not mounted)
mkdir -p /mlflow/tmp
mkdir -p /mlflow/models

# Initialize SQLite DB if not exists
if [ ! -f "/mlflow/data/mlflow.db" ]; then
    echo "Initializing SQLite database..."
    sqlite3 /mlflow/data/mlflow.db "VACUUM;"
fi

# Set permissions only for non-mounted directories
chmod -R 777 /mlflow/tmp
chmod -R 777 /mlflow/models

echo "Starting MLflow server..."
exec mlflow server \
    --backend-store-uri "${MLFLOW_TRACKING_URI}" \
    --default-artifact-root "${MLFLOW_DEFAULT_ARTIFACT_ROOT}" \
    --host 0.0.0.0 \
    --port 5000