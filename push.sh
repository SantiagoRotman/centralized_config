#!/bin/bash
# ------------------------------------------------------------------
# [Author] Santiago Rotman
#          Copia distintos archivos de la pc y hace un commit
# ------------------------------------------------------------------

SUBJECT=no_se_que_poner
VERSION=0.1.0
USAGE="Usage: ./push.sh "

# --- Option processing --------------------------------------------
if [ $# == 0 ] ; then
    echo $USAGE
    exit 1;
fi

while getopts ":vh" optname
  do
    case "$optname" in
      "v")
        echo "Version $VERSION"
        exit 0;
        ;;
      "h")
        echo $USAGE
        exit 0;
        ;;
      "?")
        echo "Unknown option $OPTARG"
        exit 0;
        ;;
      ":")
        echo "No argument value for option $OPTARG"
        exit 0;
        ;;
      *)
        echo "Unknown error while processing options"
        exit 0;
        ;;
    esac
  done

shift $(($OPTIND - 1))

param1=$1
param2=$2
# -----------------------------------------------------------------

LOCK_FILE=/tmp/${SUBJECT}.lock

if [ -f "$LOCK_FILE" ]; then
echo "Script is already running"
exit
fi

# -----------------------------------------------------------------
trap "rm -f $LOCK_FILE" EXIT
touch $LOCK_FILE

# -----------------------------------------------------------------
cp /home/santi/.config/i3/* ./
cp -r /home/santi/.fonts ./
cp /home/santi/.bashrc ./
cp /etc/bash.bashrc ./


git add *
git add .bashrc
git add .fonts

git commit -m "$1"
#git remote add centralized_config https://github.com/SantiagoRotman/centralized_config.git
git push -u centralized_config master

# -----------------------------------------------------------------
