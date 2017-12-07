#!/bin/sh

# creates data directory
if [ -d "/data/db" ]
  then echo "Directory: /data/db Exists"
  else mkdir -p /data/db
fi

# removes lockfile from persistent storage on boot
if [ -f "/data/db/mongod.lock" ]
  then rm -f /data/db/mongod.lock
  else "lock file to be created by service"
fi

# docker entrypoint (pid 1), run as root user
[ "$1" = "mongod" ] || exec "$@" || exit $?

# ensure db is owned by user mongodb
[ "$(stat -c %U /data/db)" = mongodb ] || chown -R mongodb /data/db

# whack root privilege, exec as mongodb user
command=exec; for x; do command="$command '$x'"; done
exec su -s /bin/sh -c "$command" mongodb
