#!/bin/sh
# `pwd` should be /opt/prm
APP_NAME="prm"

if [ "${APP_MIGRATE}" == "true" ]; then
  echo "[WARNING] Migrating database!"
  ./bin/$APP_NAME command "${APP_NAME}_tasks" migrate!
fi;
