#!/usr/bin/env bash
set -e

# this if will check if the first argument is a flag
# but only works if all arguments require a hyphenated flag
# -v; -SL; -f arg; etc will work, but not arg1 arg2
if [ "${1:0:1}" = '-' ]; then
    set -- nvchecker "$@"
fi

# check if running nvchecker
if [ "$1" = 'nvchecker' ]; then
  exec nvchecker "$@"
fi

# else default to run whatever the user wanted like "bash"
exec "$@"
