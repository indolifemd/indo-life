FROM        node:20-bullseye-slim

LABEL       author="IndoLife" maintainer="arkindolife@gmail.com"

RUN         apt update \
            && apt -y install ffmpeg iproute2 git sqlite3 libsqlite3-dev python3 python3-dev ca-certificates dnsutils tzdata zip tar curl build-essential libtool iputils-ping \
            && useradd -m -d /home/container container

RUN         npm install npm@latest -g
RUN         npm install pm2 -g

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
