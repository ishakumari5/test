FROM ubuntu:20.04
MAINTAINER Aryan Karan <aryankaran28022004@gmail.com>

RUN apt-get update > /dev/null \
 && export DEBIAN_FRONTEND=noninteractive \
 && apt-get install nano curl git axel rsync aria2 sudo -y > /dev/null \
 && adduser --gecos "" --disabled-password aryan && echo 'aryan:aryan' | chpasswd && usermod -aG sudo aryan \
 && ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime || echo "Please Install tzdata first" && date

# Increase current space
RUN echo -e "\n\nDisk Free space:\n\n" && df -h && echo 'if [ $(if [ $(readlink /home/aryan | wc -c) != 0 ]; then echo $(readlink /home/aryan); else echo oops; fi) != /workspace/aryan ];then rm -rf /home/aryan && mkdir /workspace/aryan && ln -s /workspace/aryan /home/aryan && chown -R aryan:aryan /home/aryan /workspace && chmod 717 /workspace/*; else echo Welcome; fi' > /root/.bashrc
