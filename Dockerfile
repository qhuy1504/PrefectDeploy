# Image chính thức của Prefect
FROM python:3.11-slim

# Cài đặt hệ thống & Prefect
RUN apt-get update && apt-get install -y curl && \
    pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir prefect

# Tạo thư mục làm việc
WORKDIR /app

# Copy các file cấu hình (start script, v.v.)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY start.sh ./start.sh
RUN chmod +x ./start.sh

# Prefect Orion UI chạy mặc định cổng 4200
EXPOSE 4200

# Lệnh khởi chạy
CMD ["./start.sh"]
