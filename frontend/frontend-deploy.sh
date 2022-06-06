#!/bin/bash
docker network create -d bridge sausage_network || true
gitlab.praktikum-services.ru:5050/yuki.isoya23/sausage-store/sausage-frontend:latest
docker stop frontend || true
docker rm frontend || true
set -e
docker run -d --name frontend \
    --network=sausage_network \
	-p 3543:3543 \
    --restart always \
    --pull always \
	gitlab.praktikum-services.ru:5050/yuki.isoya23/sausage-store/sausage-frontend:latest