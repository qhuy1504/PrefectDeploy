#!/bin/bash

echo "== STARTING PREFECT SERVER =="
# Chạy Prefect server ở nền
prefect server start --host 0.0.0.0 --port 4200 &

# Lấy PID để theo dõi nếu cần
SERVER_PID=$!

# Đợi server khởi động
sleep 60

echo "== STARTING PREFECT WORKER =="
# Đặt biến môi trường trỏ về server nội bộ
export PREFECT_API_URL=http://127.0.0.1:4200/api

# Bắt đầu worker
prefect worker start --pool local-process-pool --type process

# Nếu worker chết, kill server để container thoát
kill $SERVER_PID
