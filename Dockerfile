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

RUN cd /home/aryan && mkdir havoc && cd havoc \
&& ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa <<< y && cat ~/.ssh/id_rsa.pub && sleep 1m \
&& ssh -T git@github.com || echo Git Verification done \
&& git config --global user.name "Aryan Karan" \
&& git config --global user.email "aryankaran28022004@gmail.com" \
&& git config --global color.ui true \
&& repo init -u git@github.com:aryan-karan/havoc_manifest-private.git -b private --depth=1 \
&& repo sync -c -j`expr 2 \* $(nproc --all)` --force-sync --no-clone-bundle --no-tags \
&& ls -lhA \
&& git clone git@github.com:aryan-karan/kernel_xiaomi_onclite.git -b havoc-11 --depth=1 kernel/xiaomi/onclite \
&& git clone git@github.com:aryan-karan/device_xiaomi_onclite.git -b havoc-11 --depth=1 device/xiaomi/onclite \
&& git clone git@github.com:aryan-karan/vendor_xiaomi_onclite.git -b lineage-18.1 --depth=1 vendor/xiaomi/onclite \
&& . build/envsetup.sh \
&& export USE_CCACHE=1 \
&& export OUT_DIR=~/out \
&& export CCACHE_DIR=~/ccache \
&& ccache -s \
&& export CCACHE_EXEC=$(which ccache) \
&& ccache -M 100G \
&& export HAVOC_BUILD_TYPE=Official \
&& export HAVOC_MAINTAINER="Aryan-Karan-(aryan-karan)" \
&& export HAVOC_GROUP_URL=https://t.me/havoc_os_onclite \
&& brunch havoc_onclite-user || echo "Seems Something gone wrong!"

# export out_file=$OUT/*onclite*.zip && echo $out_file
# if [ -f $out_file ]; then echo "Hurray buuld Completed" && export build_completed=1; else echo "Oops build yet not completed" && export build_completed=0; fi
