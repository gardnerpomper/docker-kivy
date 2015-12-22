# docker-kivy
base container for development of kivy apps.

The instructions here were developed on a Macintosh. I believe they
should work under linux as well. There are some parts, dealing with
ssh tunnel setup and user accounts, that may not translate to
windows.

## Thanks to:
This container contains very little of my own work. It is mainly the
result of copying from a couple other projects and tweaking a
little. Most of my work is contained in the scripts for configuring
the user and the screen resolution. The two main sources for finding
out how the container works are:
- [thewtex/docker-opengl](https://github.com/thewtex/docker-opengl) - the OPENgl and noVNC configuration
- [alej0varas/kivy-docker](https://github.com/alej0varas/kivy-docker) - the kivy setup

## Running the container
A sample script, run.sh, is included to run the container. It also
serves as an example of the type of configuration that is
supported. Sample usage:

```
run.sh
```

This will start the container in the background, with a virtual
X-windows screen resolution of 800x600. A new user will be created in
the container, with the same username as the person running the
script, and a UID/GID of 501/20. The users HOME directory will also be
mounted as /host.

## Displaying the container screen
The container can either be viewed from your browser, or using a VNC
client. Both ports are dynamically mapped, so you must do a "docker
ps" to see the port mappings. Example:

```
CONTAINER ID  IMAGE COMMAND                 CREATED        STATUS         PORTS                                             NAMES
d843418a82ec  kivy  "/tmp/at_runtime.sh /"  11 minutes ago Up 11 minutes  0.0.0.0:32789->5900/tcp,0.0.0.0:32788->6080/tcp   reverent_wright
```

### noVNC
The noVNC server is running on the container port 6080, so to connect
with the browser, point it at "http://localhost:32788"

### VNC
The VNC server is running on port 5900, so point the VNC client to
port 32789 (in this case)

### docker-machine
If running the container on a Mac or PC, where you must use
docker-machine, the localhost addresses will not work. Your browser
URL should instead reference the IP address of your docker-machine
virtualbox VM, which is probably something like 192.168.99.100, giving
a URL of http://192.168.99.100:32788

For a VNC connection, you can set up an SSH tunnel to the virtualbox
VM. On OS/X, here is a sample command line to do that:

```
ssh -i $DOCKER_CERT_PATH/id_rsa -N -T -L *:5901:localhost:32770 docker@$(docker-machine ip default) &
```
## Working on Kivy
Once you have the container up and running and can see the screen, you
need to log into it to run your kivy applications. A test application
is included (tests.py) [copied from
https://github.com/alej0varas/kivy-docker]. To run it, first exec
into the container:

```
docker exec -it -u $(id -un) gardnerpomper/docker-kivy bash
```

Then run the test from your hosts file system (your path may be different):

```
python /host/git/docker-kivy/tests.py
```

This should put a "Hello World" widget on the container display in VNC
or your browser.
