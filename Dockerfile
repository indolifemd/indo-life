# Use official Node.js 20 image based on Debian Bullseye
FROM node:20-bullseye-slim

# ARG untuk metadata saat build
ARG IMAGE_VERSION
ARG IMAGE_REVISION
ARG IMAGE_CREATED

# Metadata about the image
LABEL author="IndoLife" \
      maintainer="arkindolife@gmail.com" \
      description="A Docker image for running Node.js applications with PM2 and essential utilities." \
      org.opencontainers.image.title="IndoLife Node.js 20 Base" \
      org.opencontainers.image.description="Custom Node.js 20 image with PM2, Git auto-clone, and essential system utilities for Pterodactyl." \
      org.opencontainers.image.version="${IMAGE_VERSION}" \
      org.opencontainers.image.url="https://github.com/indolifemd/indo-life" \
      org.opencontainers.image.source="https://github.com/indolifemd/indo-life" \
      org.opencontainers.image.documentation="https://github.com/indolifemd/indo-life/wiki" \
      org.opencontainers.image.authors="IndoLife Dev <arkindolife@gmail.com>" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.revision="${IMAGE_REVISION}" \
      org.opencontainers.image.created="${IMAGE_CREATED}"

# Simpan sebagai environment variable di container
ENV IMAGE_VERSION=${IMAGE_VERSION}
ENV IMAGE_REVISION=${IMAGE_REVISION}
ENV IMAGE_CREATED=${IMAGE_CREATED}

# Update and install required dependencies
RUN apt update && apt -y install \
        ffmpeg \
        iproute2 \
        git \
        sqlite3 \
        libsqlite3-dev \
        python3 \
        python3-dev \
        ca-certificates \
        dnsutils \
        tzdata \
        zip \
        tar \
        curl \
        build-essential \
        libtool \
        iputils-ping \
        libatk-bridge2.0-0 \
        libatk1.0-0 \
        libcups2 \
        libdrm2 \
        libxcomposite1 \
        libxdamage1 \
        libxrandr2 \
        libgbm1 \
        libasound2 \
        libpangocairo-1.0-0 \
        libpango-1.0-0 \
        libx11-xcb1 \
        libxcb1 \
        libxext6 \
        libxfixes3 \
        libnss3 \
        libx11-6 \
        libxrender1 \
        libjpeg62-turbo \
        libgtk-3-0 \
        fonts-liberation \
        libappindicator3-1 \
        lsb-release \
        xdg-utils \
        wget \
        ca-certificates \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

# Create a non-root user 'container' and set home directory
RUN useradd -m -d /home/container container

# Install the latest npm and PM2 globally
RUN npm install -g npm@latest \
    && npm install -g pm2

# Set the user to 'container' to run the application
USER container

# Set environment variables for user and home directory
ENV USER=container \
    HOME=/home/container

# Set working directory to the home directory of the container
WORKDIR /home/container

# Copy the entrypoint script into the container
COPY ./entrypoint.sh /entrypoint.sh

# Default command to run the entrypoint script
CMD [ "/bin/bash", "/entrypoint.sh" ]
