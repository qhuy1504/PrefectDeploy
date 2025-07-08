# Dùng image chính thức từ Prefect
FROM prefecthq/prefect:3-python3.13

# Đặt thư mục làm việc
WORKDIR /opt/prefect/flows

# Cài đặt các thư viện cần thiết
COPY requirements.txt .
RUN pip install -r requirements.txt

# Cài đặt Supervisor để chạy nhiều tiến trình song song
RUN apt-get update && apt-get install -y supervisor

# Copy toàn bộ code và file cấu hình
COPY . .

# Copy file supervisor config
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Copy file .env (nếu có)
COPY .env .env

RUN echo "==== DONE SETUP ===="

# Set environment variables từ file .env (prefect sẽ đọc biến ENV tại runtime)
ENV PREFECT_API_DATABASE_CONNECTION_URL=${PREFECT_API_DATABASE_CONNECTION_URL}
ENV PREFECT_API_URL=${PREFECT_API_URL}
ENV DATABASE_URL=${DATABASE_URL}

# Expose port cho Prefect UI
EXPOSE 4200

# Khởi chạy supervisor (chạy đồng thời prefect server, worker, flow)
CMD ["/usr/bin/supervisord"]
