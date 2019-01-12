#!/usr/bin/env bash
ARGSARR=( "$@" )
ARGSLEN=${#ARGSARR[@]}
if [ $ARGSLEN -eq 0 ]; then
  ARGSARR=(".env" "traefik.toml" "docker-compose.yml")
fi

for i in "${ARGSARR[@]}"
do
   echo "unassuming-unchanges (showing changes in status) for: $i"
   git update-index --no-assume-unchanged "$i"
done
