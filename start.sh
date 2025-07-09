#!/bin/bash

set -e

# Load biến môi trường
if [ -f .env ]; then
  export $(cat .env | xargs)
else
  echo ".env file not found"
  exit 1
fi

echo "== PREFECT CONFIG =="
echo "PREFECT_API_URL=$PREFECT_API_URL"
echo "PREFECT_UI_URL=$PREFECT_UI_URL"

export PREFECT_API_URL=$PREFECT_API_URL
export PREFECT_UI_URL=$PREFECT_UI_URL

echo "== STARTING PREFECT SERVER (background) =="
prefect server start --host 0.0.0.0 --port 4200 &

SERVER_PID=$!

# Chờ server khởi động
sleep 60

echo "== SERVING FLOW =="
python my_flows.py

wait $SERVER_PID
