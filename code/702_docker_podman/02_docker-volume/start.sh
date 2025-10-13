#!/usr/bin/env bash

# start the local postgres container
podman compose up -d
# which is using the volume created earlier
# to access the existing data again
