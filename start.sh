#!/bin/bash

echo "== SETTING API URL ENV =="
export PREFECT_API_URL=https://prefectdeploy-production.up.railway.app/api
export PREFECT_UI_URL=https://prefectdeploy-production.up.railway.app

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
