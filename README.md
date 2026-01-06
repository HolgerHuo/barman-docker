# barman-docker

This repo contains files used to build a [docker](https://www.docker.com) image
for running [BaRMan](https://github.com/EnterpriseDB/barman), the "Backup and
Recovery Manager for PostgreSQL."

## Getting the image

`docker pull ghcr.io/holgerhuo/barman-docker:latest`

## Usage

- Data Volume: `/var/lib/barman`
- Config: `/etc/barman.conf` and `/etc/barman.d/*.conf`
