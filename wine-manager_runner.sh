#!/bin/bash

# Setup Default Function
export Default_Env=$(dirname $0)

if [[ ! -x ${Default_Env}/wine-manager_function.sh ]]; then
   echo "wine-manager_runner: function spirit can not found or premission died!"
   echo "wine-manager_runner: please check it install correctly or fix it form other files!"
   exit 1
else
   source ${Default_Env}/wine-manager_function.sh
fi

check_user
run_sprit

usage()
{
   echo "This Program can diff running wine
<>:must set value,[]:can set value,!:instead of '\"',#:instead of ' '
Usage:
  Wine
   --c-i-w                   create default wine contain
   --c-i=<NAME>              create wine contain
   --winename=<NAME>         specify wine runtime
   --programexec=[Program and argument] set run program to runtime

  Runner manager
   Log:
    --debug                  enable debug
    --log                    log write
    --inlog                  log write in wine contain
            
   Envsetup:
    --print-set              print correct config
    --reset-set              [undefine!]reset the config
    --cset-<NAME>=<VALUE>    set index to config
    --dset-<NAME>            delete index form config
   System Bash
    --bash                   use environment to run bash
         "
}

# set sconfig
env_set()
{
   D=$*
   export SG_${D//--cset-}
   log_write_manager "add env config: ${D//--cset-}"
   sg_set_set
   unset D
}

#

# init
sg_load
wine_search
wine_s_runner
#

if [[ ! $* ]];then
   usage
   exit 0
fi

for i in $@
do
   if [[ $(echo '#'$i | grep '#--c-i=') ]];then
      wine_c ${i//--c-i=}
      continue
   fi
   if [[ $(echo '#'$i | grep '#--winename=') ]];then
      wine_select ${i//--winename=}
      continue
   fi
   if [[ $(echo '#'$i | grep '#--programexec=') ]];then
      proexec1=${i//--programexec=}
      wine_runner ${proexec1//#/' '}
      continue
   fi
   if [[ $(echo '#'$i | grep '#--cset-') ]];then
      env_set ${i//--cset-}
      continue
   fi
   if [[ $(echo '#'$i | grep '#--dset-') ]];then
      sg_env_del ${i//--dset-}
      continue
   fi
   
   case "$i" in
      "--c-i-w")
         wine_ciw
      ;;
      "--help")
         usage
      ;;
      "--print-set")
         sg_print_set
      ;;
      "--bash")
         bash -c 'cd;bash;exit $?'
      ;;
      *)
         echo "This swith name $i undefine!"
      ;;
   esac
done
