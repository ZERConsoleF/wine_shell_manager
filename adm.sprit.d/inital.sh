# inital XDG RUNTIME Environment
sudo mkdir -p /run/user/$(id wineman -u)
sudo chown $(id wineman -un): /run/user/$(id wineman -u)

pulseaudio --check
if [[ $? != "0" ]];then
   pulseaudio -D
fi

pactl load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1 2>/dev/null
