#!/usr/bin/env bash

USER=${1:-admin}
PASS=${2:-12345} 

echo $(htpasswd -nb $USER $PASS) | sed -e s/\\$/\\$\\$/g
