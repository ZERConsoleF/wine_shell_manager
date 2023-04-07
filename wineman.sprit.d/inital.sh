# set currect HOME
export HOME=/opt/wine-manager/home

#inital XDG
export XDG_RUNTIME_DIR=/run/user/$(id -u)

#inital pulseaduio
pulseaudio --check

if [[ "$?" != "0" ]]; then
   pulseaudio --start
fi

