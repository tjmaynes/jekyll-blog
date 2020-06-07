#!/bin/bash

set -e

VOLUME_DIRECTORY=$1

if [[ -z $VOLUME_DIRECTORY ]]; then
	echo "Please provide a volume directory for running the docker image"
	exit 1
fi

docker rm -f nginx-blog || true
docker run --name nginx-blog \
	--publish 80:80 \
	--publish 443:443 \
	--volume $VOLUME_DIRECTORY:/usr/share/nginx/html \
	nginx:1.15.7
