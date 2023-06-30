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
   echo " 6) printer desktop linker"
   echo " 7) exit"
   echo ""
   echo ""
}
linker()
{
   if [[ -r $F_HOME/.local/share/applications ]];then
      for i in $F_HOME/.local/share/applications/wine-manager_*
      do
         echo "$(basename $i):${i#*=}"
      done
   fi
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
