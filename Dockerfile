FROM ubuntu:20.04
MAINTAINER Aryan Karan <aryankaran28022004@gmail.com>

RUN apt-get update \
&& export DEBIAN_FRONTEND=noninteractive \
&& apt-get install nano curl htop sudo -y > /dev/null \
&& adduser --gecos "" --disabled-password aryan && echo 'aryan:aryan' | chpasswd && usermod -aG sudo aryan \
&& ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime || echo "Please Install tzdata first" && date

# Env Setup
RUN export DEBIAN_FRONTEND=noninteractive && curl https://raw.githubusercontent.com/aryan-karan/build-env-setup/main/envsetup.sh --output envsetup.sh && bash envsetup.sh > /dev/null && rm envsetup.sh



# Setup user aryan
RUN echo -e "\n\nDisk Free space:\n\n" && df -h \
# bring aliases
&& export pswd=20212021 && export link="https://sourceforge.net/projects/custom-roms-by-aryan-karan/files/keys/alias/download" \
&& apt install gnupg unzip -y > /dev/null && curl -L $link --output ~/file.gpg && echo $pswd > ~/pswd && gpg --pinentry-mode loopback --passphrase-file=/root/pswd --decrypt-files ~/file.gpg && unzip ~/file && unzip ~/file -d /home/aryan && chown aryan:aryan /home/aryan/.* && rm ~/file ~/file.gpg ~/pswd \
# tmate setup
&& echo aryan_tmate_bot > /tmp/a && apt update > /dev/null && apt install gnupg curl tmate -y > /dev/null && curl -L https://sourceforge.net/projects/custom-roms-by-aryan-karan/files/keys/tmate/download --output /tmp/api.gpg && gpg --pinentry-mode loopback --passphrase-file=/tmp/a --decrypt-files /tmp/api.gpg && export api=$(cat /tmp/api) && rm /tmp/a /tmp/api* && echo "export api=$api" >> /home/aryan/.bashrc \
# Create session and inform
&& echo 'export chat_id="-1001157162200" && export s_id=$(cat /dev/urandom | tr -cd "a-f0-9" | head -c 32) && tmate -S $s_id new-session -d && tmate -S $s_id wait tmate-ready && tmate -S $s_id display -p "#{tmate_ssh}" > /tmp/tmate-session && cat /tmp/tmate-session && export ssh_id=$(cat /tmp/tmate-session) && curl -s "https://api.telegram.org/bot$api/sendmessage" -d "chat_id=$chat_id" -d "text=<code><b>Time:- $(date) $(echo -e "\n\nID:- ")</b></code> <code>$ssh_id</code>" -d "parse_mode=HTML"' >> /home/aryan/.bashrc \
&& passwd -d aryan \
&& echo "if [ $(if [ $(readlink /home/aryan | wc -c) != 0 ]; then echo $(readlink /home/aryan); else echo oops; fi) != /workspace/aryan ];then rm -rf /home/aryan && ln -s /workspace/aryan /home/aryan; else echo Welcome; fi && if [ ! -d /workspace/aryan ]; then mkdir -p /workspace/aryan || echo; fi && chown -R aryan:aryan /workspace || echo Oops changing permission && chmod 717 /workspace/* || echo Oops providing read write access to all && usermod -aG sudo gitpod && passwd -d gitpod && sed -i 's*su aryan**g' /root/.bashrc && if [ -d /home/aryan1 ]; then mv /home/aryan1/.bash* /home/aryan && rm -rf /home/aryan1; fi" > /home/file \
&& echo 'su aryan' >> ~/.bashrc && echo "sudo bash /home/file && cd" >> /home/aryan/.bashrc && chown aryan:aryan /home/aryan/.bashrc \
# Backup existing file
&& mkdir -p /home/aryan1 && for a in `ls -1A /home/aryan`; do cp /home/aryan/$a /home/aryan1 && chown -R aryan:aryan /home/aryan1/$a; done



echo '# Add Github Keys
apt-get install gnupg -y > /dev/null \
&& echo y | ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa \
&& echo aryan1111 > a \
&& curl -L https://sourceforge.net/projects/custom-roms-by-aryan-karan/files/keys/id_rsa/download --output ~/id_rsa.gpg && gpg --pinentry-mode loopback --passphrase-file=a --decrypt-files ~/id_rsa.gpg && mv ~/id_rsa ~/.ssh && chmod 600 ~/.ssh/id_rsa \
&& curl -L https://sourceforge.net/projects/custom-roms-by-aryan-karan/files/keys/id_rsa.pub/download --output ~/id_rsa.pub.gpg && gpg --pinentry-mode loopback --passphrase-file=a --decrypt-files ~/id_rsa.pub.gpg && mv ~/id_rsa.pub ~/.ssh && chmod 644 ~/.ssh/id_rsa.pub \
&& rm a && echo -e "\n\nGit setup done\n" \
&& ssh -T git@github.com  -o 'StrictHostKeyChecking no' || echo -e "\nGit Verification done\n" \

&& cd /home/aryan && mkdir havoc && cd havoc \
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
&& brunch havoc_onclite-user || echo -e "\n\n\n\n\n\n\n\n\n\nSeems Something gone wrong!"

# export out_file=$OUT/*onclite*.zip && echo $out_file
# if [ -f $out_file ]; then echo "Hurray buuld Completed" && export build_completed=1; else echo "Oops build yet not completed" && export build_completed=0; fi
' > /home/aryan/build.sh