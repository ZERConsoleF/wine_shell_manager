#!/bin/bash

VERSION=1.0.0
DEFAULT_DIR=/opt/wine-manager

if [[ "$(id -u)" != "0" ]];then
  echo "This must be running with root!"
  exit 127
fi

if [[ $* ]];then
  echo "Warning:argument to install is future function!"
fi

echo "===Welcome to Wine Manager Installer==="
echo "Install Version:${VERSION}"
echo "Installer script local workspace:$(dirname $0)"
echo ""
#read -p "Input install directory [Default:${DEFAULT_DIR}]:" s_dir
echo "Input install directory [Default:${DEFAULT_DIR}]: [Disable Input]"
echo "WARNING:Because it can make the conflict in you environment,disable it!"

if [[ ! $s_dir ]];then
  echo "You not input some string, using default!"
else
  echo "You input $s_dir,using it!"
  DEFAULT_DIR=$s_dir
fi

mkdir -p $DEFAULT_DIR

if [[ $? != "0" ]];then
  echo "Failure mkdir in $DEFAULT_DIR"
  exit 127
fi

echo "Copy files to $DEFAULT_DIR"

cp -r $(dirname $0)/* $DEFAULT_DIR

echo "config Wine Manager"

/usr/sbin/useradd wineman -r -d $DEFAULT_DIR/home
echo "$DEFAULT_DIR"'/user_login.sh '"$DEFAULT_DIR"'/wine-manager.sh $*' > /usr/bin/wine-manager.sh
chmod +x /usr/bin/wine-manager.sh
/usr/bin/ln -sf "$DEFAULT_DIR/wine-manager_function.sh" /usr/bin
echo "$DEFAULT_DIR"'/user_login.sh '"$DEFAULT_DIR"'/wine-manager_runner.sh $*' > /usr/bin/wine-manager_runner.sh
chmod +x /usr/bin/wine-manager_runner.sh
chown -R wineman: $DEFAULT_DIR

echo "config sudo configure"
ln -s $(dirname $0)/sudo_conf/wine-manager /etc/sudoers.d

read -p "Do you want to install fake deb package [N/y]:" yn

if [[ $yn == "Y" || $yn == "y" ]];then
  echo "Build fake deb package..."
  echo "#/bin/bash" >> $(dirname $0)/deb-build/DEBIAN/postinst
  echo "echo Not support reconfigure!" >> $(dirname $0)/deb-build/DEBIAN/postinst
  echo "#/bin/bash" >> $(dirname $0)/deb-build/DEBIAN/postrm
  echo 'case "$*" in
    purge)' >> $(dirname $0)/deb-build/DEBIAN/postrm
  echo "cd $DEFAULT_DIR;$DEFAULT_DIR/UNINSTALL.sh "'$*' >> $(dirname $0)/deb-build/DEBIAN/postrm
  echo ';;
    *)
     ;;
  esac' >> $(dirname $0)/deb-build/DEBIAN/postrm
  echo "exit 0" >> $(dirname $0)/deb-build/DEBIAN/postrm
  dpkg -b $(dirname $0)/deb-build $(dirname $0)/tmp
  dpkg -i $(dirname $0)/tmp/*
  rm -rf $(dirname $0)/tmp/*
else
  echo "Over!"
fi

echo "Done."
