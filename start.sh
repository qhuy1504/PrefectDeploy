#!/bin/bash

echo "== SETTING API URL ENV =="
export PREFECT_API_URL=https://prefect-production-c7b6.up.railway.app/api
export PREFECT_UI_URL=https://prefect-production-c7b6.up.railway.app

echo "== STARTING PREFECT SERVER =="
prefect server start --host 0.0.0.0 --port 4200 --ui-url $PREFECT_UI_URL &

SERVER_PID=$!
sleep 60

echo "== STARTING PREFECT WORKER =="
prefect worker start --pool local-process-pool --type process

kill $SERVER_PID
