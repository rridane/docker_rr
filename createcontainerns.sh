#!/bin/bash

read -p "containerid ?" CONTAINER_ID

PID=$(docker inspect -f '{{.State.Pid}}' $CONTAINER_ID)

mkdir -p /var/run/netns/

ln -sfT /proc/$PID/ns/net /var/run/netns/$CONTAINER_ID

echo "namespace: $CONTAINER_ID"
