#!/bin/sh

isCommand() {
  # Retain backwards compatibility with common CI providers,
  # see: https://github.com/composer/docker/issues/107
  echo "A: $1"
  if [ "$1" = "sh" ] || [ "$1" = "bash" ] ; then
    return 1
  fi

  dbdiff --help > /dev/null 2>&1
}

# check if the first argument passed in looks like a flag
if [ "${1#-}" != "$1" ]; then
  set -- dbdiff "$@"
# check if the first argument passed in is composer
elif [ "$1" = 'dbdiff' ]; then
  set -- "$@"
# check if the first argument passed in matches a known command
elif isCommand "$1"; then
  set -- dbdiff "$@"
fi

echo "EXEC: $@"

exec "$@"
