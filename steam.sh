#!/usr/bin/env bash
set -e

cd /srv/eco

unset LC_ALL

/usr/local/bin/steamcmd.sh +runscript /update.steam

PARAMS="$@"

[ -z "$PARAMS" ] && PARAMS=-nogui

if [ -x /srv/eco/local.sh ] ; then
  bash /srv/eco/local.sh
fi

exec mono /srv/eco/EcoServer.exe $PARAMS
