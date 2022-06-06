#!/bin/bash

if [ "$1" = "nginx" ]; then
    echo "NGINX started"
fi

exec "$@"
