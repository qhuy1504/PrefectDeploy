#!/bin/bash

source .env

echo "== PREFECT UI/ API =="
echo "PREFECT_API_URL=$PREFECT_API_URL"
echo "PREFECT_UI_URL=$PREFECT_UI_URL"

# Ép Prefect biết đúng URL public
export PREFECT_API_URL=$PREFECT_API_URL
export PREFECT_UI_URL=$PREFECT_UI_URL


echo "== STARTING PREFECT SERVER =="
# Khởi chạy prefect server
prefect server start --host 0.0.0.0 --port 4200 &

SERVER_PID=$!
sleep 60

echo "== STARTING PREFECT WORKER =="
# Worker dùng API URL đã set bên trên
prefect worker start --pool local-process-pool --type process

sleep 10

echo "== SERVING FLOW =="
python my_flows.py

wait $SERVER_PID
