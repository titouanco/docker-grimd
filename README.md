# 🐳 eownis/grimd

[![build status](https://drone.titouan.co/api/badges/t/docker-grimd/status.svg)](https://drone.titouan.co/t/docker-grimd)

[![](https://images.microbadger.com/badges/version/eownis/grimd:master.svg)](https://microbadger.com/images/eownis/grimd:master "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/eownis/grimd:master.svg)](https://microbadger.com/images/eownis/grimd:master "Get your own image badge on microbadger.com")

[Grimd](https://github.com/looterz/grimd). Built by [Drone](https://drone.titouan.co/t/docker-grimd) and pushed to [Docker Hub](https://hub.docker.com/r/eownis/grimd/).

## Usage

Extract of my `docker-compose.yml` file, adapt to your needs :

```yaml
...
  grimd:
    image: eownis/grimd:latest
    container_name: grimd
    restart: always
    ports:
      - "10.242.42.40:8080:8080/tcp"
      - "10.242.42.40:53:53/tcp"
      - "10.242.42.40:53:53/udp"
    volumes:
      - ./grimd:/config
    environment:
      - UID=1000
      - GID=1000
...
```

If you use a `docker-compose.yml` file you can pretty much copy paste the snippet, change the ip address (`10.242.42.40` is my server ip address on my [zerotier](https://www.zerotier.com) network) for the exposed ports and be done with it.

For the configuration of grimd you can place your `grimd.toml` file inside the `config` directory, if there is no config file when the container boot a default one will be placed in the `config` directory.
