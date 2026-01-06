# docker-barman

This repo contains files used to build a [docker](https://www.docker.com) image
for running [BaRMan](https://github.com/2ndquadrant-it/barman), the "Backup and
Recovery Manager for PostgreSQL."

It is easily used in conjunction with the `tbeadle/postgres:<version>-barman`
images at https://hub.docker.com/r/tbeadle/postgres/.

## Getting the image

`docker pull ghcr.io/holgerhuo/barman-docker:latest`

## Usage

- Data Volume: `/var/lib/barman`
- Config: `/etc/barman.conf` and `/etc/barman.d/*.conf`
