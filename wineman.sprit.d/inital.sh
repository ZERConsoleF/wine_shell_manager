# set currect HOME
export HOME=/opt/wine-manager/home

#inital XDG
export XDG_RUNTIME_DIR=/run/user/$(id -u)

#inital pulseaduio
pulseaudio --check

if [[ "$?" != "0" ]]; then
   pulseaudio --start
   sleep 5
   #pacmd load-module module-virtual-sink sink_name=VirtualSink
   #pacmd set-default-sink VirtualSink
   pactl load-module module-tunnel-sink "server=tcp:127.0.0.1 sink_name=VirtualSink"
fi
