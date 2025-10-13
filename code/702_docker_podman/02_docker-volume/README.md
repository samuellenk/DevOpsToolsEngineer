# Docker Volume example

This folder contains a simple `docker volume` demo.

It provides a [Postgres](https://www.postgresql.org/) container using this volume for persistent data storage.

You can use the database in [DBeaver](https://dbeaver.io/).

When you open the database client you first create a new connection. The credentilas can be found in `.env`.

## Runing the example

1. Create the volume:

```bash
# use the script:
./create_colume.sh
# or run it directly:
podman volume create pgdata
```

2. Run the container:

```bash
# use the script:
./start.sh
# or run it directly:
podman compose up -d
# another way of starting the container is:
podman run -d --name pg -e POSTGRES_PASSWORD=postgres -v pgdata:/var/lib/postgresql/data -p 5432:5432 postgres:latest
```

> `podman`in the commands can be swapped for `docker` :smile:

## Other things you can do

List your docker volumes:

```bash
podman volume ls
```

Inspect the specific volume:

```bash
podman volume inspect pgdata
```

Look inside the volume:


```bash
sudo ls -alh ~/.local/share/containers/storage/volumes/pgdata/_data/
```

> Content of the volume is the same as on a real Postgres server

Stop or start the container again:

```bash
podman stop pg
podman start pg
```

Package in a `Dockerfile`:

```Dockerfile
FROM postgres:latest
ENV POSTGRES_PASSWORD=postgres
VOLUME /var/lib/postgresql/data
EXPOSE 5432
```

Build an image from the `Dockerfile`:

```bash
docker build -t my-postgres .
```

Run the image:

```bash
docker run -d --name pg2 -v pgdata:/var/lib/postgresql/data my-postgres
```

Connect to the running container:

```bash
docker exec -it pg2 /bin/bash
```
