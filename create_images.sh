#! /bin/bash

git pull
docker build -t rbeniwal26119/basic-django .
docker push rbeniwal26119/basic-django

docker run -p 8000:8000 rbeniwal26119/basic-django:latest