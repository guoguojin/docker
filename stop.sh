#!/usr/bin/env bash

DEV_NET=$(docker network ls --filter name=development --quiet)

if [[ -z $DEV_NET ]]; then
  echo "creating development docker network"
  docker network create development
fi

usage() {
  echo "Usage: stop.sh [service]"
  echo ""
  echo "where service is any of the services listed"
  echo "example: stop.sh redis"
  echo "         to stop the redis service"
}

if [[ $# == 0 ]] || [[ $1 == "--help" ]]; then
  usage
  exit
fi

if [[ ! -d $1 ]]; then 
  usage
  exit 1
fi

docker-compose -f $1/docker-compose.yaml down
