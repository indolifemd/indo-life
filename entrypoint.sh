#!/bin/bash

# Pastikan Git repository di-update jika perlu
if [[ -d .git ]] && [[ "$AUTO_UPDATE" == "1" ]]; then
    echo "Pulling latest changes from git..."
    git pull
fi

# Install package Node.js jika diperlukan
if [[ ! -z "$NODE_PACKAGES" ]]; then
    echo "Installing Node packages..."
    /usr/local/bin/npm install $NODE_PACKAGES
fi

# Uninstall package Node.js jika diperlukan
if [[ ! -z "$UNNODE_PACKAGES" ]]; then
    echo "Uninstalling Node packages..."
    /usr/local/bin/npm uninstall $UNNODE_PACKAGES
fi

# Install dependencies jika file package.json ada
if [ -f /home/container/package.json ]; then
    echo "Installing npm dependencies..."
    /usr/local/bin/npm install
fi

# Menjalankan aplikasi sesuai dengan CMD yang diatur
if [[ ! -z "$CMD_RUN" ]]; then
    echo "Running application with CMD: $CMD_RUN"
    /usr/local/bin/$CMD_RUN
elif [[ ! -z "$CMD_RIN" ]]; then
    echo "Running application with PM2: $CMD_RIN"
    /usr/local/bin/pm2 start $CMD_RIN
else
    echo "No CMD to run, exiting."
    exit 1
fi
