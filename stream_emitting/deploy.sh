#!/bin/bash

cmd=$1

# dockerhub username
DOCKER_USER="mlopsvn"
PROJECT="mlops_crash_course"

usage() {
    echo "deploy.sh <command>"
    echo "Available commands:"
    echo " start                start emiting"
    echo " stop                 stop emiting"
}

if [[ -z "$cmd" ]]; then
    echo "Missing command"
    usage
    exit 1
fi

start_emit() {
    docker-compose -f docker-compose.yaml up
}

stop_emit() {
    docker-compose -f docker-compose.yaml down
}

case $cmd in 
    start)
        start_emit
        ;;
    stop)
        stop_emit
        ;;
    *)
        echo -n "Unknown command: $cmd"
        ;;
esac