#!/bin/bash
# Initialize SQLite DB if not exists
if [ ! -f "/mlflow/data/mlflow.db" ]; then
  echo "Initializing SQLite database..."
  sqlite3 /mlflow/data/mlflow.db "VACUUM;"
fi

# Start MLflow server
exec mlflow server \
    --backend-store-uri sqlite:////mlflow/data/mlflow.db \
    --default-artifact-root file:///mlflow/data/artifacts \
    --host 0.0.0.0 \
    --port 5000