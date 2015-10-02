#!/usr/bin/env bash

# update the git repo
function updateRepo() {
    #on mac see if we have XCode installed and then use it
    if [ -e /Applications/Xcode.app/ ]
    then
        xcrun git pull
    else
        git pull
    fi
}

function dotbotInstall() {
  # or just source the install file
  # make sure dotbot is current and happy
  set -e

  CONFIG="install.conf.yaml"
  DOTBOT_DIR="dotbot"

  DOTBOT_BIN="bin/dotbot"
  BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

  cd "${BASEDIR}"
  git submodule update --init --recursive "${DOTBOT_DIR}"

  "${BASEDIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -d "${BASEDIR}" -c "${CONFIG}" "${@}"
}

###
##
#

#update git
if ( updateRepo )
  then
  # re-install alliases
  dotbotInstall
else
  echo "Pulling from the repo failed."
fi

source $HOME/.bash_profile
