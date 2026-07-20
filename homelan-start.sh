#!/usr/bin/env bash

docker stop $(docker ps -aq)

echo "Starting common services..."
cd /home/okmuc216/workspace/docker_common || exit
docker compose up -d mysql

# echo "Starting shopyensao services..."
# cd /home/okmuc216/workspace/webservice/shopyensao.com/laradock || exit
# docker compose up -d mysql apache2

echo "Starting ranking services..."
cd /home/okmuc216/workspace/notejs_rank_gg || exit
pm2 start ./bin/www

echo "Starting redmine started."
cd /home/okmuc216/workspace/backlog.redmine || exit
docker compose up -d mysql redmine phpmyadmin

echo "Starting nodejs sudoku services..."
cd /home/okmuc216/workspace/crazyzo/game-portal-next-js || exit
docker compose -f docker/docker-compose.yml up -d