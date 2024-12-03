# Use official Node.js 20 image based on Debian Bullseye
FROM node:20-bullseye-slim

# Metadata about the image
LABEL author="IndoLife" \
      maintainer="arkindolife@gmail.com" \
      description="A Docker image for running Node.js applications with PM2 and essential utilities."

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
    && rm -rf /var/lib/apt/lists/*  # Clean up APT cache to reduce image size

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
