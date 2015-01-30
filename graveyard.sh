#!/bin/bash

TEMPLATE=mayoi/shell

# clean stopped containers
docker ps -a | grep -E "$TEMPLATE.*Exited" | awk '{print "docker rm " $1}' | sh
