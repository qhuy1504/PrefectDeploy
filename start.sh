#!/bin/bash

set -e  # Bắt lỗi nếu có lệnh nào fail

source .env

echo "== PREFECT CONFIG =="
echo "PREFECT_API_URL=$PREFECT_API_URL"
echo "PREFECT_UI_URL=$PREFECT_UI_URL"

export PREFECT_API_URL=$PREFECT_API_URL
export PREFECT_UI_URL=$PREFECT_UI_URL

echo "== STARTING PREFECT SERVER (background) =="
prefect server start --host 0.0.0.0 --port 4200 &

SERVER_PID=$!

# Đợi Prefect Server khởi động hoàn tất
echo "== WAITING FOR PREFECT SERVER to be ready =="
sleep 60

echo "== SERVING FLOW (my_flows.py) =="
python my_flows.py &

# Giữ tiến trình sống
wait $SERVER_PID
