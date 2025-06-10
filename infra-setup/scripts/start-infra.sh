#!/bin/bash

NETWORK_NAME="infra-net"

# Kiểm tra network đã tồn tại chưa
if ! docker network ls --format '{{.Name}}' | grep -wq "$NETWORK_NAME"; then
  echo "Network '$NETWORK_NAME' chưa tồn tại. Đang tạo mới..."
  docker network create "$NETWORK_NAME"
  echo "Tạo network '$NETWORK_NAME' thành công."
else
  echo "Network '$NETWORK_NAME' đã tồn tại, bỏ qua tạo mới."
fi

# Chạy docker-compose
docker-compose -f ../docker-compose-kafka.yml up -d
docker-compose -f ../docker-compose-database.yml up -d
docker-compose -f docker-compose-prometheus.yml up -d
docker-compose -f docker-compose-grafana.yml up -d