# MNIST MLflow Example

This example demonstrates how to train a simple RandomForest classifier on the MNIST dataset and log metrics and the model to an MLflow server with S3/MinIO artifact storage.

## Prerequisites

- Python 3.10 or 3.11 (recommended)
- pip or conda
- MLflow server running with S3/MinIO artifact storage (see main README)

## Setup

1. **Create and activate a Python environment (recommended):**
   ```bash
   conda create -n mlflow-mnist python=3.10
   conda activate mlflow-mnist
   ```
   Or use `python3.10 -m venv venv && source venv/bin/activate`

2. **Install requirements:**
   ```bash
   pip install -r requirements.txt
   ```

## Usage

1. **Set S3/MinIO environment variables (if not set globally):**
   ```bash
   export MLFLOW_S3_ENDPOINT_URL=http://localhost:9000
   export AWS_ACCESS_KEY_ID=minioadmin
   export AWS_SECRET_ACCESS_KEY=minioadmin
   ```
   Or let the script set them for you (already included in the example).

2. **Run the example:**
   ```bash
   python mnist_mlflow_example.py
   ```

3. **View results:**
   - Open the MLflow UI at [http://localhost:5000](http://localhost:5000) or with your ip
   - Artifacts (models) will be stored in your MinIO bucket (`mlflow-artifacts`).
   - You can view and download them from the MinIO web UI at [http://localhost:9001](http://localhost:9001) (user/pass: minioadmin) or with your ip

## Notes
- The script will automatically create an MLflow experiment called `mnist-s3-example`.
- If you encounter errors with numpy/scikit-learn, ensure you are using Python 3.10 or 3.11.
- For more advanced MLflow usage, see the [MLflow documentation](https://mlflow.org/). 