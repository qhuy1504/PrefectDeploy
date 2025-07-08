FROM prefecthq/prefect:3-python3.13

WORKDIR /opt/prefect/flows

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

# Set biến môi trường
ENV PREFECT_API_KEY=${PREFECT_API_KEY}
ENV PREFECT_API_URL=${PREFECT_API_URL}
ENV DATABASE_URL=${DATABASE_URL}

# Chạy Prefect Worker
CMD ["prefect", "worker", "start", "--pool", "local-process-pool"]
