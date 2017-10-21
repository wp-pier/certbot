#!/bin/sh
set -eu

run-certbot.sh

exec "$@"
