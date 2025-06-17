# Use multi-platform base image
FROM python:3.8-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libsqlite3-dev \
    sqlite3 \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements first for better caching
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Create necessary directories
RUN mkdir -p /mlflow/data/artifacts

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose MLflow port
EXPOSE 5000

# Set environment variables
ENV MLFLOW_TRACKING_URI=sqlite:////mlflow/data/mlflow.db
ENV MLFLOW_DEFAULT_ARTIFACT_ROOT=file:///mlflow/data/artifacts

# Use entrypoint script
ENTRYPOINT ["/entrypoint.sh"]