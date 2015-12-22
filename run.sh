#!/bin/bash
#
# ----- run the container, with dynamic port assignment
# ----- container options are set through environment variables
# ----- NEWUSER	   : username to create in the container
# ----- NEWUID     : uid for the new user
# ----- NEWGID     : gid for the new user
# ----- RESOLUTION : screen resolution inside the container
# ----- This also maps the users home directory into the container
# ----- as the "/host" mount point
#
# ----- to view the possible resolutions, exec into the running container
# ---- and look at the /etc/X11/xorg.conf file
#
CONTAINER=kivy
#docker run -it --rm -e NEWUID=$(id -u) -e NEWGID=$(id -g)	\
docker run -d -P -e NEWUSER=$(id -un) -e NEWUID=501 -e NEWGID=20	\
        -e RESOLUTION="800x480"						\
        -v $HOME:/host							\
        -l runby=$(id -un)						\
       $CONTAINER $*
