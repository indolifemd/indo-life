#!/bin/bash

# Warna terminal
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
NC='\033[0m'

# Informasi versi & Git
VERSION="1.0.0"
REVISION=$(git rev-parse --short HEAD)
CREATED=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
IMAGE_NAME="ghcr.io/indolifemd/node20-indolife"

# Banner
clear
echo -e "${RED}=============================="
echo -e "${GREEN}     IndoLife Docker Build     "
echo -e "${RED}==============================${NC}"
sleep 1

# Mulai proses build
echo -e "${CYAN}Membangun image dengan metadata...${NC}"
docker buildx build . \
  --tag $IMAGE_NAME:$VERSION \
  --label org.opencontainers.image.title="IndoLife Node.js 20 Base" \
  --label org.opencontainers.image.description="Custom Node.js 20 image with PM2, Git auto-clone, and essential system utilities for Pterodactyl." \
  --label org.opencontainers.image.version="$VERSION" \
  --label org.opencontainers.image.url="https://github.com/indolifemd/indo-life" \
  --label org.opencontainers.image.source="https://github.com/indolifemd/indo-life" \
  --label org.opencontainers.image.documentation="https://github.com/indolifemd/indo-life/wiki" \
  --label org.opencontainers.image.authors="IndoLife Dev <arkindolife@gmail.com>" \
  --label org.opencontainers.image.licenses="MIT" \
  --label org.opencontainers.image.revision="$REVISION" \
  --label org.opencontainers.image.created="$CREATED" \
  --push  # Hapus baris ini jika belum mau push otomatis

# Selesai
if [ $? -eq 0 ]; then
  echo -e "${GREEN}Build selesai! Image: ${YELLOW}$IMAGE_NAME:$VERSION${NC}"
else
  echo -e "${RED}Build gagal.${NC}"
fi
