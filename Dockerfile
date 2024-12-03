FROM        node:20-bullseye-slim

# Set timezone
ENV TZ=Asia/Jakarta
RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

# Metadata for the image
LABEL       author="IndoLife" maintainer="arkindolife@gmail.com"

# Install dependencies including Zsh, Git, Curl, and Powerline fonts
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
    zsh \
    fonts-powerline \
    && useradd -m -d /home/container container

# Install npm and pm2 globally
RUN npm install npm@latest -g && \
    npm install pm2 -g

# Set Zsh as the default shell
RUN chsh -s $(which zsh) container

# Switch to non-root user for security reasons
USER container
ENV USER=container HOME=/home/container

# Install Oh My Zsh for the agnoster theme
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
    && rm -rf /home/container/.oh-my-zsh/custom/themes/agnoster.zsh-theme \
    && cp /home/container/.oh-my-zsh/themes/agnoster.zsh-theme /home/container/.oh-my-zsh/custom/themes/agnoster.zsh-theme

# Set the working directory inside the container
WORKDIR /home/container

# Copy the entrypoint script
COPY ./entrypoint.sh /entrypoint.sh

# Set the entrypoint for the container
CMD ["/bin/bash", "/entrypoint.sh"]
