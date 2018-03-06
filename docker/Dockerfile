#
# docker build -t gretkowski/kubeevo:v1 -f Dockerfile .
#
# docker tag gretkowski/kubeevo:1v demokuberegistry.azurecr.io/kubeevo:v1
# docker push demokuberegistry.azurecr.io/kubeevo:v1
#

FROM ubuntu:xenial
WORKDIR "/"
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8


# First get the OS up to date, and then install python.
RUN apt-get update
RUN apt-get -y dist-upgrade
RUN apt-get -y install python3 python3-pip git build-essential


# Install roboschool prereq's and start the roboschool setup
RUN apt-get -y install cmake ffmpeg pkg-config qtbase5-dev libqt5opengl5-dev libassimp-dev libpython3.5-dev libboost-python-dev libtinyxml-dev
RUN pip3 install pyopengl
RUN pip3 install gym
RUN git clone https://github.com/openai/roboschool.git


# Bullet3 physics engine setup - used by roboschool
RUN git clone https://github.com/olegklimov/bullet3 -b roboschool_self_collision
RUN mkdir -p bullet3/build
RUN cd /bullet3/build; cmake -DBUILD_SHARED_LIBS=ON -DUSE_DOUBLE_PRECISION=1 -DCMAKE_INSTALL_PREFIX:PATH=/roboschool/roboschool/cpp-household/bullet_local_install -DBUILD_CPU_DEMOS=OFF -DBUILD_BULLET2_DEMOS=OFF -DBUILD_EXTRAS=OFF  -DBUILD_UNIT_TESTS=OFF -DBUILD_CLSOCKET=OFF -DBUILD_ENET=OFF -DBUILD_OPENGL3_DEMOS=OFF ..
RUN cd /bullet3/build; make -j4
RUN cd /bullet3/build; make install
RUN pip3 install -e /roboschool


# Virtual Frame Buffer - needed as X11 display target where no monitor exists.
RUN apt-get -y install xvfb x11vnc x11-xkb-utils xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic x11-apps
ADD xvfb_init /etc/init.d/xvfb
RUN chmod a+x /etc/init.d/xvfb


# Install prereqs & evolution-strategies-starter
RUN apt-get -y install tmux screen vim
RUN apt-get -y install python3-click python3-redis python3-h5py
RUN pip3 install tensorflow==0.12.0
RUN git clone https://github.com/openai/evolution-strategies-starter.git
# Make it roboschool compatible.
RUN sed -i "s|^    import gym$|    import gym, roboschool|g" /evolution-strategies-starter/es_distributed/es.py
RUN sed -i "s|^    import gym$|    import gym, roboschool|g" /evolution-strategies-starter/scripts/viz.py


# Install Redis, needed for evolution-strategies-starter
RUN apt-get -y install redis-server
RUN sed -i "s|^bind 127.0.0.1|bind 0.0.0.0|g" /etc/redis/redis.conf
RUN sed -i "s|^# unixsocket /var/run/redis/redis.sock$|unixsocket /var/run/redis/redis.sock|g" /etc/redis/redis.conf
RUN set -i "s|^# unixsocketperm 700$|unixsocketperm 700|g" /etc/redis/redis.conf

# This directory will be attached as a volume for storing results
RUN mkdir -p /logdir

# This is our ES task definition
ADD humanoid.json /humanoid.json

# Startup scripts for master and worker node.
ADD master-start.sh /master-start.sh
ADD worker-start.sh /worker-start.sh
RUN chmod a+xr /master-start.sh /worker-start.sh
