#!/bin/bash

USERNAME=janikeuskirchen
# CONTAINER_NAME=ubuntu_$(printf "%x\n" $RANDOM$RANDOM$RANDOM);
CONTAINER_NAME=ubuntu 
# mac-subsystem-ubuntu 
# calling it 'ubuntu' assuming I will only need one subsystem at a time.

if [[ $(docker ps --format {{.Names}}) == *$CONTAINER_NAME* ]]; then
	# In this case, the container already exists, and we simply want to enter its shell: 
	docker exec -it $CONTAINER_NAME /bin/bash /mnt/mac/.ubuntu_shrc;
	docker exec -it $CONTAINER_NAME sh;
else 
	# Only create a new container, if it doesn't already exist.
	docker run -itd --rm --name $CONTAINER_NAME -v /Users/$USERNAME/:/mnt/mac/ ubuntu sleep infinity; 
	docker exec -it $CONTAINER_NAME /bin/bash /mnt/mac/.ubuntu_launchrc;
	docker exec -it $CONTAINER_NAME /bin/bash /mnt/mac/.ubuntu_shrc;
	docker exec -it $CONTAINER_NAME sh;
	docker stop $CONTAINER_NAME;
fi 