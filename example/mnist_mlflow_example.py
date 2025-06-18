import mlflow
import os
import numpy as np
from sklearn.datasets import fetch_openml
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score

# Set MLflow S3/MinIO environment variables
os.environ['MLFLOW_S3_ENDPOINT_URL'] = 'http://localhost:9000'
os.environ['AWS_ACCESS_KEY_ID'] = 'minioadmin'
os.environ['AWS_SECRET_ACCESS_KEY'] = 'minioadmin'

mlflow.set_tracking_uri('http://localhost:5000')
mlflow.set_experiment('mnist-s3-example')

# Load MNIST data
print('Downloading MNIST...')
X, y = fetch_openml('mnist_784', version=1, return_X_y=True, as_frame=False)
X = X / 255.0  # Normalize

y = y.astype(np.int32)

# Split data
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Train model
print('Training RandomForest...')
model = RandomForestClassifier(n_estimators=50, random_state=42, n_jobs=-1)
model.fit(X_train, y_train)

# Evaluate
y_pred = model.predict(X_test)
accuracy = accuracy_score(y_test, y_pred)
print(f'Accuracy: {accuracy}')

# Log to MLflow
with mlflow.start_run() as run:
    mlflow.log_param('n_estimators', 50)
    mlflow.log_metric('accuracy', accuracy)
    mlflow.sklearn.log_model(model, 'model')
    print(f"Run ID: {run.info.run_id}")
    print(f"Artifact URI: {run.info.artifact_uri}")

print('Done!') 