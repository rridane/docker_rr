#!/bin/bash

read -p "namespace du container ?" CONTAINER_ID

rm -rf /var/run/netns/$CONTAINER_ID

echo "namespace $CONTAINER_ID supprimé"
