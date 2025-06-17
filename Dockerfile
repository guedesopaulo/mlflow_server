# ARM64 base image for Jetson
FROM arm64v8/python:3.8-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    libsqlite3-dev \
    && rm -rf /var/lib/apt/lists/*

# Install MLflow
RUN pip install --no-cache-dir \
    mlflow==2.13.1 \
    pyarrow

# Create storage directories
RUN mkdir -p /mlflow/{artifacts,db}

# Expose MLflow port
EXPOSE 5000

# Startup command
CMD ["mlflow", "server", \
     "--backend-store-uri", "sqlite:////mlflow/db/mlflow.db", \
     "--default-artifact-root", "file:///mlflow/artifacts", \
     "--host", "0.0.0.0"]