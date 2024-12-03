#!/bin/bash

# Set warna
RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
MAGENTA='\033[1;35m'
NC='\033[0m' # No Color

# Banner IndoLife
clear
echo -e "${RED}"
echo "=============================="
echo -e "     ${MAGENTA}Welcome to IndoLife${NC}     "
echo "=============================="
echo -e "${NC}"
sleep 1

# Animasi Loading
echo -e "${CYAN}Loading system information...${NC}"
sleep 1
for i in {1..5}; do
    echo -n "."
    sleep 0.5
done
echo -e "${NC}\n"

# Informasi Sistem
OS=$(lsb_release -d | awk -F'\t' '{print $2}')
IP=$(hostname -I | awk '{print $1}')
CPU=$(grep -m1 'model name' /proc/cpuinfo | awk -F': ' '{print $2}')
RAM=$(awk '/MemTotal/ {printf "%.2f GB", $2/1024/1024}' /proc/meminfo)
DISK=$(df -h / | awk '/\/$/ {print $2}')
TIMEZONE=$(cat /etc/timezone)
DATE=$(date '+%Y-%m-%d %H:%M:%S')

# Animasi untuk Menampilkan Info Sistem dengan Delay
echo -e "${GREEN}Fetching system details...${NC}"
sleep 1
echo -e "${BLUE}OS        : ${CYAN}$OS${NC}"
sleep 0.5
echo -e "${YELLOW}IP Address: ${CYAN}$IP${NC}"
sleep 0.5
echo -e "${MAGENTA}CPU       : ${CYAN}$CPU${NC}"
sleep 0.5
echo -e "${GREEN}RAM       : ${CYAN}$RAM${NC}"
sleep 0.5
echo -e "${YELLOW}SSD       : ${CYAN}$DISK${NC}"
sleep 0.5
echo -e "${MAGENTA}Timezone  : ${CYAN}$TIMEZONE${NC}"
sleep 0.5
echo -e "${CYAN}Date      : ${NC}$DATE"
sleep 1

# Banner Penutupan
echo -e "${RED}==============================${NC}"
sleep 1

# Script Tambahan untuk Menjalankan Server
cd /home/container

# Make internal Docker IP address available to processes.
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

# Print Node.js Version
echo -e "${GREEN}Node.js Version:${NC} $(node -v)"
sleep 1

# Replace Startup Variables
MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo -e "${CYAN}Modified Startup Command:${NC}"
sleep 1
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Jalankan Server
echo -e "${YELLOW}Starting the server...${NC}"
sleep 1
eval ${MODIFIED_STARTUP}

# Jalankan perintah bawaan container
exec "$@"
