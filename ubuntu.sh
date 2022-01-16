#!/bin/bash
# ubuntu subsystem on mac

USERNAME=janikeuskirchen
CONTAINER_NAME=ubuntu
# calling it 'ubuntu' assuming I will only need one subsystem at a time.  
# otherwise, I could generate a random container name, like this:  
# CONTAINER_NAME=ubuntu_$(printf "%x\n" $RANDOM$RANDOM$RANDOM);
TAG=$1
# see supported tags: https://hub.docker.com/_/ubuntu
if [[ $TAG == "" ]]; then 
	TAG=latest 
fi 

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
	docker stop $CONTAINER_NAME;
fi 