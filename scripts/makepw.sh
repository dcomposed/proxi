#!/usr/bin/env bash

USER=${1:-admin}
PASS=${2:-12345}

echo -e "Copy one of the below depending on where you will paste it:\n"

echo '=== for use in docker compose (set traefik.frontend.auth.basic=) ==='
echo $(htpasswd -nb $USER $PASS) | sed -e s/\\$/\\$\\$/g

echo '=== for use in .env: ==='
echo "AUTH_STRING=$(htpasswd -nb $USER $PASS)"
