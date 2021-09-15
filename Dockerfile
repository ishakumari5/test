FROM ubuntu:20.04
MAINTAINER Aryan Karan <aryankaran28022004@gmail.com>

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get install sudo -y \
 && adduser --gecos "" --disabled-password aryan && echo 'aryan:aryan' | chpasswd && usermod -aG sudo aryan

# Change Hostname
RUN echo host > /etc/hostname
