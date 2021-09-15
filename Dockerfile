FROM ubuntu:18.04
MAINTAINER Aryan Karan <aryankaran28022004@gmail.com>

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get install sudo coreutils -y \
 && whoami \
 && adduser --gecos "" --disabled-password aryan && usermod -aG sudo aryan
