# Add Github Keys
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
