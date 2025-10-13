# Docker Static Web Page example

This folder serves a simple `index.html` in an [nginx](https://hub.docker.com/_/nginx) container.

## Runing the example

1. Build the container:

```bash
docker build -t my-static-site .
```

2. Run the container:

```bash
docker run -d \
  --name my-site \
  -p 8080:80 \
  my-static-site
```

3. Open the Static Page

```bash
curl -s http://localhost:8080 | head -n 5
```

- should show the content of `index.html`

## Other things you can do

Connect to the running container:

```bash
docker exec -it my-site /bin/sh
```

View the container logs:

```bash
docker logs -f my-site
```

> equivalent of `tail -f` in Bash

Inspect the running container:

```bash
docker inspect my-site | jq .
```

> You may have to install `jq` first using `sudo apt install jq`
