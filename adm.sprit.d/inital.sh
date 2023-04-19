# inital XDG RUNTIME Environment
sudo mkdir -p /run/user/$(id wineman -u)
sudo chown $(id wineman -un): /run/user/$(id wineman -u)

RU=""
RC=""
if [[ $SUDO_UID ]];then
  RU=$SUDO_UID
  RC="sudo -u $(id $RU -un)"
else
  RU=$UID
fi

ret=$($RC bash -c 'pulseaudio --check;echo $?')

if [[ $ret != "0" ]];then
   $RC pulseaudio --start
   sleep 5
fi

$RC pactl load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1:4713 auth-anonymous=1 2>/dev/null

