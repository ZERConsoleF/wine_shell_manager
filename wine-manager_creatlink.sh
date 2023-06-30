#!/bin/bash
echo "DESKTOP to USER:$USER"
read -p "Contain Name:" cn
if [[ ! "$cn" ]];then
  echo "You must identfly contain name!"
  exit 127
fi

read -p "Name:" ne

if [[ ! "$ne" ]];then
  echo "You must identfly name!"
  exit 127
fi

read -p "Exec argument:" ea

if [[ ! "$cn" ]];then
  cn="winecfg"
fi

read -p "Commit:" ci

read -p "Console Mode?[y/N]:" cm

if [[ "$cm" == "y" ]] | [[ "$cm" == "Y" ]];then
  cm="/bin/env output=1 sudo wine-manager_runner.sh --winename=mc --programexec="
else
  cm="sudo wine-manager_runner.sh --winename=mc --programexec="
fi

read -p "Terminal?[y/N]:" tl

if [[ "$tl" == "y" ]] | [[ "$tl" == "Y" ]];then
  tl="true"
else
  tl="false"
fi

mkdir -p ~/.local/share/applications

echo "Creat Desktop:~/.local/share/applications/wine-manager_"$cn"_"$ne".desktop"

echo '[Desktop Entry]
Version=1.0
Type=Application' > ~/.local/share/applications/wine-manager_"$cn"_"$ne".desktop
echo "Name=$ne" >> ~/.local/share/applications/wine-manager_"$cn"_"$ne".desktop
echo "Comment=$ci" >> ~/.local/share/applications/wine-manager_"$cn"_"$ne".desktop
echo "Exec=$cm'$ea'" >> ~/.local/share/applications/wine-manager_"$cn"_"$ne".desktop
echo "Terminal=$tl" >> ~/.local/share/applications/wine-manager_"$cn"_"$ne".desktop
echo "StartupNotify=false" >> ~/.local/share/applications/wine-manager_"$cn"_"$ne".desktop

echo "Done."
sleep 3
