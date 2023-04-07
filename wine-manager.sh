#!/bin/bash

# Setup Default Function
export Default_Env=$(dirname $0)

if [[ ! -x ${Default_Env}/wine-manager_function.sh ]]; then
   echo "wine-manager: function spirit can not found or premission died!"
   echo "wine-manager: please check it install correctly or fix it form other files!"
   exit 1
else
   source ${Default_Env}/wine-manager_function.sh
fi

check_user

# menu

menu()
{
   clear
   echo "Welcome the wine select contain"
   echo "Please select you choose"
   echo ""
   echo ""
   echo " 1) create delault contain"
   echo " 2) create contain"
   echo " 3) running contain"
   echo " 4) set config"
   echo " 5) delete config"
   echo " 6) print desktop linker"
   echo " 7) exit"
   echo ""
   echo ""
}
linker()
{
   LIST=()
   index=0
   for i in $default_rd/home/.local/share/applications/*
   do
   echo "$(expr $index + 1)) $(basename $i)"
      LIST+=("$i")
      index=$(expr $index + 1)
   done
   
   read -p ":" f
   CS=${LIST[$f]}
   if [[ ! $CS ]];then
      echo "Can not find,abort!"
      return
   fi
   
   echo "===Desktop Execute==="
   echo ""
   
      echo "[Desktop Entry]"
      echo "Version=1.0"
      echo "Type=Application"
      echo Name="${$(cat ${G}/.local/share/applications/wine/$1/$(basename $i) | grep Name)#*=}"
      echo Comment="${$(cat ${G}/.local/share/applications/wine/$1/$(basename $i) | grep Comment)#*=}"
      echo Exec=sudo -u wineman "${$(cat ${G}/.local/share/applications/wine/$1/$(basename $i) | grep Exec)#*=}"
      echo Icon="${$(cat ${G}/.local/share/applications/wine/$1/$(basename $i) | grep Icon)#*=}"
      echo Path="${$(cat ${G}/.local/share/applications/wine/$1/$(basename $i) | grep Path)#*=}"
      echo Terminal=true
   echo ""
   echo "======"
}

while true
do
 menu
 read -p ":" cc
 case "$cc" in
    "1")
    $default_rd/wine-manager_runner.sh --c-i-w
    ;;
    "2")
    read -p "create name:" c
    $default_rd/wine-manager_runner.sh --c-i=$c
    ;;
    "3")
    read -p "wine name:" ca
    read -p "wine command:" cb
    $default_rd/wine-manager_runner.sh --winename=$ca --programexec=$cb
    ;;
    "4")
    $default_rd/wine-manager_runner.sh --print-set
    read -p "add config[such: h=p]:" c
    $default_rd/wine-manager_runner.sh --cset-$c
    ;;
    "5")
    read -p "delete config:" c
    $default_rd/wine-manager_runner.sh --dset-$c
    ;;
    "6")
    linker
    ;;
    "7")
    exit
    ;;
    *)
    ;;
 esac
done
