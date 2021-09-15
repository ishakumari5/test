FROM ubuntu:20.04
MAINTAINER Aryan Karan <aryankaran28022004@gmail.com>

RUN apt-get update \
 && apt-get install curl axel rsync sftp scp aria2 sudo -y \
 && adduser --gecos "" --disabled-password aryan && echo 'aryan:aryan' | chpasswd && usermod -aG sudo aryan

# Set time zone
RUN export DEBIAN_FRONTEND=noninteractive && apt install tzdata -y && ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime && date

# Increase current space
mkdir /workspace/aryan && rm -rf /home/aryan && ln -s /workspace/aryan /home/aryan && chown -R aryan:aryan /home/aryan /workspace && chmod 717 /workspace/*
