#!/bin/bash

if [[ ${has_loader} ]]; then
   echo "function has been loaded!"
   #return;
fi
if [[ $debug && $debug != "0" ]];then
 echo "wine-manager_function.sh: Load function"
fi
export has_loader=1

# Setup Default var value
export Default_USER="wineman"
export default_rd=/opt/wine-manager
export random=$RANDOM
if [[ ! $output ]];then
 export output=0
fi
if [[ ! $debug ]];then
 export debug=0
fi
if [[ ! $log ]];then
 export log=0
fi
if [[ ! $inlog ]];then
 export inlog=0
fi

# check
check_user()
{
   if [[ "${USER}" != "${Default_USER}" ]]; then
      print_careful 31m"manager not run with Default User:${Default_USER}!"
      print_careful 32m"must use ${Default_USER} user to run the shell spirit!"
      exit 1
   fi
}

print_error()
{
   printf "wine-manager: Error: \033[1;31m$*\n\033[0m"
}
print_info()
{
   if [[ $debug != "0" ]];then
      printf "wine-manager: info: \033[1;32m$*\n\033[0m"
   fi
}
print_warn()
{
   if [[ $debug != "0" ]];then
      printf "wine-manager: warning: \033[1;33m$*\n\033[0m"
   fi
}
print_careful()
{
   printf "wine-manager: care: \033[5;$*\n\033[0m"
}

# screen show
full_screen_h()
{
   yes $* | sed $(stty size | awk '{printf $1}')'q'
}
full_screen_d()
{
   yes $* | sed $(stty size | awk '{printf $1}')'q' | tr -d '\n'
}

# log write
log_write_manager()
{
   if [[ $debug == "0" ]];then
      return
   fi
   
   if [[ ! -d $default_rd/logs ]];then
      mkdir -p $default_rd/logs
   fi
   
   echo "[$(date)] $*" >> $default_rd/logs/manager-$random.log
}
log_write_wine()
{
   if [[ $debug == "0" ]];then
      return
   fi
   
   if [[ ! -d $default_rd/logs ]];then
      mkdir -p $default_rd/logs
   fi
   
   echo "[$(date)] $*" >> $default_rd/logs/wine-$random.log
}

# wine
wine_ciw()
{
   if [[ ! -d $default_rd/ciw ]];then
      mkdir -p $default_rd/ciw
      print_warn "contain directory can not find,create!"
      log_write_wine "create wine contain directory"
   fi
   nohup env WINEPREFIX=$default_rd/ciw $SG_runner explorer.exe > $default_rd/logs/wine-ciw-$random.log
   log_write_wine "cc d"
}
wine_c()
{
   if [[ ! -d $default_rd/winec ]];then
      print_warn "contain directory can not find,create!"
      log_write_wine "create wine contain directory"
      mkdir -p $default_rd/winec
   fi
   
   cp -r $default_rd/ciw $default_rd/winec/$1
   echo "create!"
   wine_search
}
wine_s_runner()
{
   if [[ ! $SG_runner ]];then
      export SG_runner="$(which wine)"
      sg_set_set
   fi
}
wine_search()
{
   if [[ ! -d $default_rd/winec ]];then
      print_warn "contain directory can not find,create!"
      log_write_wine "create wine contain directory"
      mkdir -p $default_rd/winec
   fi

   export SG_winec=""
   for i in $default_rd/winec/*
   do
      if [[ -d $i/dosdevices ]];then
         export SG_winec=$SG_winec$(basename $i)";"
      fi
   done
}
wine_select()
{
   if [[ $(echo $SG_winec | grep $1) ]];then
      export SG_wsc=$1
      export WINEPREFIX=$default_rd/winec/$SG_wsc
   else
      print_error "we can not find the contain,skip"
   fi
}
wine_runner()
{
   proexec1=${*//!/"\""}
   if [[ $output == "0" ]];then
      bash -c "WINEPREFIX=$default_rd/winec/$SG_wsc $SG_runner $proexec1" 1>>$default_rd/logs/wine-$random.log 2>>$default_rd/logs/wine-$random.log
   else
      bash -c "WINEPREFIX=$default_rd/winec/$SG_wsc $SG_runner $proexec1"
   fi
}
# endwine

# manager
sg_load()
{
   if [[ ! -e $default_rd/sconfig ]];then
      print_warn "sconfig can not find,create!"
      touch $default_rd/sconfig
   fi
   
   for i in $(cat $default_rd/sconfig)
   do
      export $i
      export ${i//"SG_"/" "}
   done
}
sg_print_set()
{
   echo $(env | grep "SG")
}
sg_env_set()
{
   if [[ ! -e $default_rd/sconfig ]];then
      print_warn "sconfig can not find,create!"
      touch $default_rd/sconfig
   fi
   export SG_$1=$2
   export $1=$2
   sg_set_set
   log_write_manager "add env config: SG_$1=$2"
}
sg_env_del()
{
   if [[ ! -e $default_rd/sconfig ]];then
      print_warn "sconfig can not find,create!"
      touch $default_rd/sconfig
   fi
   unset SG_$1
   unset $1
   sg_set_set
   log_write_manager "del env config: SG_$1"
}
sg_set_set()
{
   if [[ ! -e $default_rd/sconfig ]];then
      print_warn "sconfig can not find,create!"
      touch $default_rd/sconfig
   fi
   
   echo $(env | grep "SG") > $default_rd/sconfig
   log_write_manager "write config"
   
}
run_sprit()
{
   for i in $default_rd/wineman.sprit.d/*.sh; do
      if [[ -r $i ]]; then
         source $i
      fi
   done
}
# endmanager
