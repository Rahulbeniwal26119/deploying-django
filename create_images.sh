#! /bin/bash

git pull
docker build -t rbeniwal26119/basic-django .
docker push rbeniwal26119/basic-django

docker stop starwars
docker rm starwars

docker run -p 8000:8000 --name starwars rbeniwal26119/basic-django:latest