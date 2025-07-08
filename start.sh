#!/bin/bash

echo "== STARTING PREFECT ORION SERVER =="
prefect orion start --host 0.0.0.0 --port 4200 &
ORION_PID=$!

sleep 10  # Chờ server khởi động xong

echo "== CREATING WORK POOL IF NOT EXISTS =="
prefect work-pool inspect local-process-pool || \
prefect work-pool create local-process-pool --type process

echo "== STARTING PREFECT WORKER =="
prefect worker start --pool local-process-pool --type process &

# Giữ container sống
wait $ORION_PID
