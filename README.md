# sandmill-proxy

WebOne retro HTTP proxy for Sandmill. Converts modern web content to HTTP/1.0 + JPEG for Mac OS 8 / Netscape 2.02.

## What it does

- Proxies HTTP/1.0 requests from retro browsers through modern HTTPS
- Converts PNG/WebP images to JPEG, resizes to 320x240 max
- Downgrades SSL/TLS, follows redirects, strips incompatible headers

## Deployment (Dokku)

```sh
dokku apps:create sandmill-proxy
git remote add dokku dokku@sandmill.org:sandmill-proxy
git push dokku main
```

Set DNS: `proxy.sandmill.org` → Dokku server IP.

## Local dev

```sh
docker build -t sandmill-proxy .
docker run -p 8080:8080 sandmill-proxy
curl -x http://localhost:8080 http://example.com/
```
