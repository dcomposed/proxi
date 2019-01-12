#!/usr/bin/env bash
ARGSARR=( "$@" )
ARGSLEN=${#ARGSARR[@]}
if [ $ARGSLEN -eq 0 ]; then
  ARGSARR=(".env" "traefik.toml" "docker-compose.yml")
fi

for i in "${ARGSARR[@]}"
do
   echo "assuming-unchanged for: $i"
   git update-index --assume-unchanged "$i"
done
