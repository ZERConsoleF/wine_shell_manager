#!/bin/bash

if [[ "$(id -u)" != "0" ]];then
  echo "This must be running with root!"
  exit 127
fi

if [[ ! $(echo "$(dirname $0)" | grep /tmp) ]];then
  cp $0 /tmp
  chmod +x /tmp/$(basename $0)
  export DDNI=$(dirname $0)
  nohup /tmp/$(basename $0) $*&
fi

echo "Remove config..."

/usr/sbin/userdel wineman -f
/usr/bin/rm -rf /usr/bin/wine-manager.sh
/usr/bin/rm -rf /usr/bin/wine-manager_function.sh
/usr/bin/rm -rf /usr/bin/wine-manager_runner.sh

echo "Remove files"
rm -rf $DDNI

echo "Done."
rm -rf /tmp/$(basename $0)
exit 0
