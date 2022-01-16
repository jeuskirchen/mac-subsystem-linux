#!/bin/bash
# mac subsystem ubuntu 

USERNAME=janikeuskirchen
CONTAINER_NAME=ubuntu 
CMD=$1
# see supported tags: https://hub.docker.com/_/ubuntu
if [[ $CMD == "" ]]; then 
	# TAG=$2
	# if [[ $TAG == "" ]]; then 
	# 	TAG="latest"
	# fi 
	TAG=latest 
	if [[ $(docker ps --format {{.Names}}) == *$CONTAINER_NAME* ]]; then
		# In this case, the container already exists, and we simply want to enter its shell: 
		docker exec -it $CONTAINER_NAME /bin/bash /mnt/home/.ubuntu_shrc;
		docker exec -it $CONTAINER_NAME sh;
	else 
		# Only create a new container, if it doesn't already exist.
		docker run -itd --rm --name $CONTAINER_NAME -v /Users/$USERNAME/:/mnt/home/ ubuntu:$TAG sleep infinity; 
		docker exec -it $CONTAINER_NAME /bin/bash /mnt/home/.ubuntu_launchrc;
		docker exec -it $CONTAINER_NAME /bin/bash /mnt/home/.ubuntu_shrc;
		docker exec -it $CONTAINER_NAME sh;
	fi 
elif [[ $CMD == "exit" ]]; then 
	# Stop the ubuntu container (since it was run with --rm flag, it will also remove it.)
	docker stop $CONTAINER_NAME;
fi 
