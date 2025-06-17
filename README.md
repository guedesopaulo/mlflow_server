# MLflow Server

A cross-platform MLflow server setup that works on both Jetson Nano (Ubuntu 18.04) and Windows systems. This server is designed to run on your local network, allowing multiple machines to track and manage their ML experiments.

## Features

- Cross-platform compatibility (Windows, Linux, Jetson Nano)
- Persistent storage using SQLite
- Local network accessibility
- Docker-based deployment
- Automatic restart on failure
- Volume mounting for data persistence

## Prerequisites

- Docker
- Docker Compose
- Git

## Quick Start

1. Clone this repository:
```bash
git clone <your-repo-url>
cd mlflow_server
```

2. Create the data directory:
```bash
mkdir -p data/artifacts
```

3. Start the server:
```bash
docker-compose up -d
```

The MLflow server will be available at `http://localhost:5000` or `http://<your-ip>:5000` from other machines on your network.

## Configuration

The server is configured through environment variables in `docker-compose.yml`:

- `MLFLOW_TRACKING_URI`: Database connection string (default: SQLite)
- `MLFLOW_DEFAULT_ARTIFACT_ROOT`: Artifact storage location

**Note:** The Dockerfile explicitly installs `sqlite3` to ensure proper database initialization.

## Data Persistence

All data is stored in the `