FROM ubuntu:18.04
# MAINTAINER Michael Stucki <michael@stucki.io>


ENV \
# ccache specifics
    CCACHE_SIZE=100G \
    CCACHE_DIR=/srv/ccache \
    USE_CCACHE=1 \
    CCACHE_COMPRESS=1 \
# Extra include PATH, it may not include /usr/local/(s)bin on some systems
    PATH=$PATH:/usr/local/bin/

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y \
 && apt-get install rsync curl sudo -y
# Install build dependencies (source: https://wiki.cyanogenmod.org/w/Build_for_bullhead)
# rm -f /var/lib/apt/lists/*

ARG hostuid=1000
ARG hostgid=1000

RUN \
    groupadd --gid $hostgid --force aryan && \
    useradd --gid $hostgid --uid $hostuid --non-unique aryan && \
    rsync -a /etc/skel/ /home/aryan/

RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo \
 && chmod a+x /usr/local/bin/repo

# Add sudo permission
# RUN echo "aryan ALL=NOPASSWD: ALL" > /etc/sudoers.d/aryan

# Fix ownership
RUN chown -R aryan:aryan /home/aryan

VOLUME /home/aryan/android
VOLUME /srv/ccache

USER aryan
WORKDIR /home/aryan/android

# CMD /home/build/startup.sh
