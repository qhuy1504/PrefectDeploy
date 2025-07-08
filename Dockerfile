FROM prefecthq/prefect:3-python3.13

WORKDIR /opt/prefect/flows

# Copy requirements trước
COPY requirements.txt .
RUN pip install -r requirements.txt

# Cài đặt supervisor
RUN apt-get update && apt-get install -y supervisor

# Copy toàn bộ mã nguồn
COPY . .

# Copy file cấu hình supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 4200

# Chạy cả server và worker bằng supervisor
CMD ["/usr/bin/supervisord"]
