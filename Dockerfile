FROM prefecthq/prefect:3-python3.13

WORKDIR /opt/prefect/flows

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .


# Chạy Prefect Worker
CMD ["prefect", "worker", "start", "--pool", "local-process-pool"]
