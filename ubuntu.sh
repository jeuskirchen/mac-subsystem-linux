#!/bin/bash
# mac subsystem ubuntu 

# TODO: using docker in subsystem should control docker client on mac
# (I think there was some info on this on the WSL site?)

USERNAME=janikeuskirchen
CONTAINER_NAME=ubuntu 
CMD=$1

if [[ $CMD == "" ]]; then 
	# if [[ $2 == "" ]]; then 
	# 	TAG="latest"
	# else 
	#   TAG=$2
	# fi 
	TAG=latest 
	# see supported tags: https://hub.docker.com/_/ubuntu

	if [[ $(docker ps --format {{.Names}}) == *$CONTAINER_NAME* ]]; then
		# In this case, the container already exists, and we simply want to enter its shell: 
		docker exec -it $CONTAINER_NAME /bin/bash -c "rm ~/.bashrc;";
		docker exec -it $CONTAINER_NAME /bin/bash -c "cp /mnt/home/.ubuntu.bashrc ~/.bashrc;";
		docker exec -it $CONTAINER_NAME /bin/bash -c "cp /mnt/home/.ubuntu.bash_aliases ~/.bash_aliases;";
		docker exec -it $CONTAINER_NAME /bin/bash -c "cp /mnt/home/.ubuntu.pythonrc.py ~/.pythonrc.py;";
		docker exec -it $CONTAINER_NAME /bin/bash /mnt/home/.ubunturc;
		docker exec -it $CONTAINER_NAME /bin/bash;
	
	else 
		# Only create a new container, if it doesn't already exist.
		docker run -itd --rm --name $CONTAINER_NAME -v /Users/$USERNAME/:/mnt/home/ ubuntu:$TAG sleep infinity; 
		docker exec -it $CONTAINER_NAME /bin/bash /mnt/home/.ubuntu.launch;
		docker exec -it $CONTAINER_NAME /bin/bash -c "rm ~/.bashrc;";
		docker exec -it $CONTAINER_NAME /bin/bash -c "cp /mnt/home/.ubuntu.bashrc ~/.bashrc;";
		docker exec -it $CONTAINER_NAME /bin/bash -c "cp /mnt/home/.ubuntu.bash_aliases ~/.bash_aliases;";
		docker exec -it $CONTAINER_NAME /bin/bash -c "cp /mnt/home/.ubuntu.pythonrc.py ~/.pythonrc.py;";
		docker exec -it $CONTAINER_NAME /bin/bash /mnt/home/.ubunturc;
		docker exec -it $CONTAINER_NAME /bin/bash;

	fi 

elif [[ $CMD == "exit" ]]; then 
	# Stop the ubuntu container (since it was run with --rm flag, it will also remove it.)
	docker stop $CONTAINER_NAME;

elif [[ $CMD == "restart" ]]; then 
	# TODO: same commands as above. Put them in functions so I can call them here.
	docker stop $CONTAINER_NAME;
	docker run -itd --rm --name $CONTAINER_NAME -v /Users/$USERNAME/:/mnt/home/ ubuntu:$TAG sleep infinity; 
	docker exec -it $CONTAINER_NAME /bin/bash /mnt/home/.ubuntu.launch;
	docker exec -it $CONTAINER_NAME /bin/bash -c "rm ~/.bashrc;";
	docker exec -it $CONTAINER_NAME /bin/bash -c "cp /mnt/home/.ubuntu.bashrc ~/.bashrc;";
	docker exec -it $CONTAINER_NAME /bin/bash -c "cp /mnt/home/.ubuntu.bash_aliases ~/.bash_aliases;";
	docker exec -it $CONTAINER_NAME /bin/bash -c "cp /mnt/home/.ubuntu.pythonrc.py ~/.pythonrc.py;";
	docker exec -it $CONTAINER_NAME /bin/bash /mnt/home/.ubunturc;
	docker exec -it $CONTAINER_NAME /bin/bash;

fi 
