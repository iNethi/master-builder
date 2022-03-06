#!/bin/bash
source ../root.conf
source ./.env
mkdir -p $CHESS_VOLUME
#cd $CHESS_VOLUME
#git clone https://github.com/ornicar/lila-ws.git
#git clone https://github.com/ornicar/lila-ws.git
docker-compose config
docker-compose up -d