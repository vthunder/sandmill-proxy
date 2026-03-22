FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    wget ca-certificates imagemagick \
    && rm -rf /var/lib/apt/lists/*

# Install WebOne 0.18.1 via .deb package (includes .NET runtime dependency)
RUN wget -q https://github.com/atauenis/webone/releases/download/v0.18.1/webone.0.18.1.linux-amd64.deb \
    -O /tmp/webone.deb && \
    apt-get update && \
    apt-get install -y /tmp/webone.deb && \
    rm /tmp/webone.deb && \
    rm -rf /var/lib/apt/lists/*

COPY webone-retro.conf /etc/webone.conf

EXPOSE 8080

CMD ["/usr/local/bin/webone"]
