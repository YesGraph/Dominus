#!/bin/bash

set -e

#
# Public functions
#

init()
{
  if [[ ! -z $TRAVIS_REPO_SLUG ]]; then
    message "init" "Integration (<b>$ACTION</b>) on branch: <b>$TRAVIS_BRANCH</b>." warn warning
  else
    CURRENT_DIR=$(pwd)
    CURRENT_DIR=$(basename $CURRENT_DIR)

    message "init" "Initializing repository: $CURRENT_DIR" warn warning
  fi

  message "init" "Updating Homebrew..." trace normal

  brew_update

  message "init" "Updating xctool..." trace normal

  brew_upgrade xctool

  message "init" "Installing Cupertino gem..." trace normal

  gem_install "Cupertino"

  message "init" "Installing AtlantisPro gem..." trace normal

  gem_install "AtlantisPro"

  message "init" "Installing CocoaPods gem..." trace normal

  gem_install "CocoaPods"

  message "init" "Gems installed." debug normal

  message "init" "Checking upload tools..." trace normal

  upload_prepare
}

#
# Private functions
#

brew_update()
{
  brew update > /dev/null
}

brew_upgrade()
{
  #brew upgrade > /dev/null

  if brew outdated | grep -qx $1; then
  	brew upgrade $1
  fi
}

gem_install()
{
  local GEM=$(echo $1 | tr '[:upper:]' '[:lower:]')

  local GEM_CHECK=$(check_gem $GEM)

  if [ "$GEM_CHECK" == "false" ]; then
    gem install $GEM --no-rdoc --no-ri --no-document --quiet
  fi
}

#
# Checks if Ruby gem is installed
#
check_gem()
{
  set +e

  local RUBY_GEM_CHECK=$(gem list $1 -i)

  set -e

  echo $RUBY_GEM_CHECK
}