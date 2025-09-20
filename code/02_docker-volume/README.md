# Docker Volume exammple

This folder contains a simple `docker volume` demo.

It provides a [Postgres](https://www.postgresql.org/) container using this volume for persistent data storage.

You can use the database in [DBeaver](https://dbeaver.io/).

When you open the database client you first create a new connection. The credentilas can be found in `.env`.

## Runing the example

1. Create the volume with:

```bash
./create_colume.sh
```

2. Run the container using:

```bash
./start.sh
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
