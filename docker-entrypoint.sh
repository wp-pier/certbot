#!/bin/sh
set -eu
# Don't run Certbot first time if CMD
# was overridden.
if [ "$1" == "supercronic" ]; then
  run-certbot.sh
fi

exec "$@"
