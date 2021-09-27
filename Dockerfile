FROM ubuntu:20.04
MAINTAINER Aryan Karan <aryankaran28022004@gmail.com>

RUN apt-get update \
 && export DEBIAN_FRONTEND=noninteractive \
 && apt-get install nano curl sudo -y \
 && adduser --gecos "" --disabled-password aryan && echo 'aryan:aryan' | chpasswd && usermod -aG sudo aryan
 && ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime || echo "Please Install tzdata first" && date

# Env Setup
RUN export DEBIAN_FRONTEND=noninteractive && curl https://raw.githubusercontent.com/aryan-karan/build-env-setup/main/envsetup.sh --output envsetup.sh && bash envsetup.sh && rm envsetup.sh

# Increase current space
RUN echo -e "\n\nDisk Free space:\n\n" && df -h && echo '[ ! -d /workspace/aryan ] && mkdir /workspace/aryan && rm -rf /home/aryan && ln -s /workspace/aryan /home/aryan && chown -R aryan:aryan /home/aryan /workspace && chmod 717 /workspace/*' > /root/.bashrc
