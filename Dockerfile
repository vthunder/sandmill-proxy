FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    wget curl unzip libicu-dev ca-certificates \
    imagemagick \
    && rm -rf /var/lib/apt/lists/*

# Install .NET 8 runtime
RUN wget -q https://dot.net/v1/dotnet-install.sh && \
    chmod +x dotnet-install.sh && \
    ./dotnet-install.sh --runtime dotnet --version 8.0.14 --install-dir /opt/dotnet && \
    rm dotnet-install.sh

ENV DOTNET_ROOT=/opt/dotnet
ENV PATH=$PATH:/opt/dotnet

# Download WebOne 0.18.1 Linux x64
RUN wget -q https://github.com/atauenis/webone/releases/download/v0.18.1/WebOne.0.18.1.linux-x64.zip \
    -O /tmp/webone.zip && \
    mkdir -p /app && \
    unzip -q /tmp/webone.zip -d /tmp/webone-extracted && \
    find /tmp/webone-extracted -name "webone" -type f -exec cp {} /app/webone \; && \
    chmod +x /app/webone && \
    rm -rf /tmp/webone.zip /tmp/webone-extracted

WORKDIR /app
COPY webone-retro.conf ./

EXPOSE 8080

CMD ["/app/webone", "webone-retro.conf"]
