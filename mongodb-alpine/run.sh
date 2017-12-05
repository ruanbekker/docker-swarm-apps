#!/bin/sh

# create mongodb data directory if not exists
if [ -d "/data/db" ]
  then echo "Directory Exists"
  else mkdir -p /data/db
fi

# remove lockfile if service was not shutdown gracefully
if [ -f "/data/db/mongod.lock" ]
  then rm -rf /data/db/mongod.lock
fi

# Docker entrypoint (pid 1), run as root
[ "$1" = "mongod" ] || exec "$@" || exit $?

# Make sure that database is owned by user mongodb
[ "$(stat -c %U /data/db)" = mongodb ] || chown -R mongodb /data/db

# Drop root privilege (no way back), exec provided command as user mongodb
cmd=exec; for i; do cmd="$cmd '$i'"; done
exec su -s /bin/sh -c "$cmd" mongodb
