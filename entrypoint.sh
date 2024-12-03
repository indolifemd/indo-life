#!/bin/bash

# Set warna
RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Banner IndoLife
echo -e "${RED}"
echo "=============================="
echo "     Welcome to IndoLife     "
echo "=============================="
echo -e "${NC}"

# Informasi Sistem
OS=$(lsb_release -d | awk -F'\t' '{print $2}')
IP=$(hostname -I | awk '{print $1}')
CPU=$(grep -m1 'model name' /proc/cpuinfo | awk -F': ' '{print $2}')
RAM=$(free -h --si | awk '/^Mem:/ {print $2}')
DISK=$(df -h / | awk '/\/$/ {print $2}')
TIMEZONE=$(cat /etc/timezone)
DATE=$(date '+%Y-%m-%d %H:%M:%S')

echo -e "${GREEN}OS        : ${NC}$OS"
echo -e "${BLUE}IP Address: ${NC}$IP"
echo -e "${CYAN}CPU       : ${NC}$CPU"
echo -e "${YELLOW}RAM       : ${NC}$RAM"
echo -e "${GREEN}SSD       : ${NC}$DISK"
echo -e "${BLUE}Timezone  : ${NC}$TIMEZONE"
echo -e "${CYAN}Date      : ${NC}$DATE"

echo -e "${RED}==============================${NC}"

# Konfigurasi tambahan
cd /home/container

# Membuat IP internal Docker tersedia untuk proses
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

# Cetak versi Node.js
node -v

# Ganti variabel startup
MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Jalankan server
eval ${MODIFIED_STARTUP}
