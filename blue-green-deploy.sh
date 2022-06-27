#! /bin/bash
docker pull gitlab.praktikum-services.ru:5050/yuki.isoya23/sausage-store/sausage-backend:latest
if docker ps | grep sausage-backend-green
then
    docker-compose rm -s -f sausage-backend-blue
    docker-compose up --detach sausage-backend-blue 
		until docker container ls --filter health=healthy | grep sausage-backend-blue
do
    echo "Waiting... health=healthy"
    sleep 5
done
    docker-compose stop sausage-backend-green
    echo "done, stop backend-green"
		elif docker ps | grep blue
then
    docker-compose rm -s -f sausage-backend-green
    docker-compose up --detach sausage-backend-green 
		until docker container ls --filter health=healthy | grep green
do
    echo "Waiting... health=healthy"
    sleep 5
done
    docker-compose stop backend-blue
    echo "done, stop backend-blue"
fi