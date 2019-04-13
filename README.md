# 🐳 titouanco/grimd

[![build status](https://cd.code.titouan.co/api/badges/titouan/docker-grimd/status.svg)](https://cd.code.titouan.co/titouan/docker-grimd)

[![](https://images.microbadger.com/badges/version/titouanco/grimd:master.svg)](https://microbadger.com/images/titouanco/grimd:master "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/titouanco/grimd:master.svg)](https://microbadger.com/images/titouanco/grimd:master "Get your own image badge on microbadger.com")

[Grimd](https://github.com/looterz/grimd). Built by [Drone](https://cd.code.titouan.co/titouan/docker-grimd) and pushed to [Docker Hub](https://hub.docker.com/r/titouanco/grimd/).

## Usage

Extract of my `docker-compose.yml` file, adapt to your needs :

```yaml
...
  grimd:
    image: titouanco/grimd:latest
    container_name: grimd
    restart: always
    ports:
      - "53:53/tcp"
      - "53:53/udp"
    volumes:
      - ./grimd:/config
    environment:
      - UID=1000
      - GID=1000
...
```

If you use a `docker-compose.yml` file you can pretty much copy paste the snippet and grimd will be listening on the port 53 of your host. The API is by default listening on the port 8080 inside the container so you can either add it to list of ports in the `docker-compose.yml` or use a reverse proxy.
