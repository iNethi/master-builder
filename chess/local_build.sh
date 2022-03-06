#!/bin/bash
source ../root.conf
source ./.env
mkdir -p $CHESS_VOLUME
savepwd=`pwd`
cd $CHESS_VOLUME
git clone https://github.com/ornicar/lila.git
git clone https://github.com/ornicar/lila-ws.git
cd $savepwd
docker-compose config
docker-compose up -d