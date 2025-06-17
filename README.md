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

## Data Persistence

All data is stored in the `./data` directory:
- `./data/mlflow.db`: SQLite database
- `./data/artifacts`: MLflow artifacts

## Accessing the Server

- Local access: `http://localhost:5000`
- Network access: `http://<your-ip>:5000`

## Stopping the Server

```bash
docker-compose down
```

## Troubleshooting

1. If you can't access the server:
   - Check if the container is running: `docker ps`
   - Check container logs: `docker logs mlflow_server`
   - Ensure port 5000 is not in use by another application

2. If data persistence issues occur:
   - Check permissions on the `./data` directory
   - Ensure the directory exists and is writable

## License

MIT
