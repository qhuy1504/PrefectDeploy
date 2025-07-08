#!/bin/bash

echo "== STARTING PREFECT ORION SERVER =="
# Chạy Prefect Orion ở nền
prefect orion start --host 0.0.0.0 --port 4200 &

# Đợi server khởi động xong (đảm bảo API sẵn sàng)
sleep 20

echo "== STARTING PREFECT WORKER =="
# Chạy worker kết nối tới server vừa khởi động
prefect worker start --pool local-process-pool --type process
