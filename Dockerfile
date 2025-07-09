# Image chính thức của Prefect
FROM python:3.11-slim

# Cài đặt hệ thống & Prefect
RUN apt-get update && apt-get install -y curl && \
    pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir prefect

# Tạo thư mục làm việc
WORKDIR /app

# Copy toàn bộ mã nguồn
COPY . .

# Cài requirements (nếu có)
RUN pip install --no-cache-dir -r requirements.txt || true

# Cấp quyền thực thi script
RUN chmod +x ./start.sh

# Mở cổng UI Prefect
EXPOSE 4200

# Khởi động container
CMD ["./start.sh"]
