# inital XDG RUNTIME Environment
sudo mkdir -p /run/user/$(id wineman -u)
sudo chown $(id wineman -un): /run/user/$(id wineman -u)

RU=""
#RC=""

if [[ $SUDO_UID ]];then
  RU=$SUDO_UID
  #if [[ ! $P ]];then
    #P=$(cat $(sudo -u $(id $SUDO_UID -un) bash -c 'echo ${HOME}')/.wine-manager_default_env.ini)
  #fi
  #RC="sudo -u $(id $RU -un) env ${P[@]}"
else
  RU=$UID
  #env>~/.wine-manager_default_env.ini
fi

export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$RU/bus

ret=$(DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$RU/bus bash -c 'pulseaudio --check;echo $?')

if [[ $ret != "0" ]];then
   DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$RU/bus pulseaudio --start
   sleep 5
fi

DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$RU/bus pactl load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1 2>/dev/null
