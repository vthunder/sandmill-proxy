FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    wget ca-certificates imagemagick \
    && rm -rf /var/lib/apt/lists/*

# Add Microsoft package repo for dotnet-runtime-8.0 (required by webone deb)
RUN wget -q https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb \
    -O /tmp/packages-microsoft-prod.deb && \
    dpkg -i /tmp/packages-microsoft-prod.deb && \
    rm /tmp/packages-microsoft-prod.deb

# Install WebOne 0.18.1 via .deb package
RUN wget -q https://github.com/atauenis/webone/releases/download/v0.18.1/webone.0.18.1.linux-amd64.deb \
    -O /tmp/webone.deb && \
    apt-get update && \
    apt-get install -y /tmp/webone.deb && \
    rm /tmp/webone.deb && \
    rm -rf /var/lib/apt/lists/*

COPY webone-retro.conf /etc/webone.conf

EXPOSE 8080

CMD ["/usr/local/bin/webone"]
