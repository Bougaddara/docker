#!/bin/bash

docker rm -f proyectovuelaravel
docker-compose down
docker-compose up --build -d
#docker run --name proyectovuelaravel -d -it -v proyectophp:/usr/local/apache2/htdocs -p 8083:80 proyectovuephp