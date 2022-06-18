#!/usr/bin/env bash

USER=${1:-admin}
PASS=${2:-12345}

if [[ $2 -eq '-p' ]]; then
  echo "pw?"
  read PASS
fi

AUTHSTR=$(htpasswd -nb $USER $PASS)

echo -e "Copy one of the below depending on where you will paste it:\n"

echo '=== for use in docker compose directly (escaped with double $$) ==='
DC=$(echo $AUTHSTR | sed -e s/\\$/\\$\\$/g)
echo "traefik.http.middlewares.auth.basicauth.users: $DC"

echo -e "\n=== for use in .env ==="
echo "AUTH_STRING=$AUTHSTR"
