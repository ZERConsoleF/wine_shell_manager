#!/bin/bash

OLD_PWD=${PWD}
cd $(dirname $0)
#cd /opt/wine-manager
xhost +>/dev/null

export SUF=0

sudo -p 'You will login in wineman user,give me a administor password:' bash -c "exit"
SUF=$(sudo bash -c "echo 1")
#bash -c "chown -R wineman: $(dirname $0);chmod -R 777 $(dirname $0)"

export F_HOME=$HOME

if [[ "$SUF" == "0" ]]; then
   echo "Login failure!"
   exit 127
fi

for i in ./adm.sprit.d/*.sh; do
   if [[ -r $i ]]; then
      source $i
   fi
done
cd "${OLD_PWD}"
sudo -u wineman env DISPLAY=${DISPLAY} XAUTHORITY=${XAUTHORITY} $*
exit $?
