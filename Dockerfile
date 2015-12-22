# This Dockerfile is used to build an xfce image based on Centos
FROM thewtex/opengl
MAINTAINER Gardner Pomper gardner@networknow.org

RUN apt-get -y update

RUN apt-get install -y python-setuptools python-pygame python-opengl
RUN apt-get install -y python-gst0.10 python-enchant gstreamer0.10-plugins-good python-dev
RUN apt-get install -y build-essential libgl1-mesa-dev libgles2-mesa-dev zlib1g-dev python-pip
RUN apt-get install -y git
RUN pip install --upgrade Cython==0.23

RUN cd && git clone git://github.com/kivy/kivy.git
RUN cd && cd kivy && make
RUN cd && cd kivy && make install

COPY at_runtime.sh /tmp/
#COPY start.sh runas_me.sh /tmp/
RUN chmod +x  /tmp/*.sh

ENTRYPOINT ["/tmp/at_runtime.sh"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
