FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src
COPY webone/ .
RUN dotnet publish -c Release -r linux-x64 --self-contained true -o /app

FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    ca-certificates imagemagick \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build /app /usr/local/bin/webone-app
COPY webone-retro.conf /etc/webone.conf

EXPOSE 8080

CMD ["/usr/local/bin/webone-app/webone", "-config", "/etc/webone.conf"]
