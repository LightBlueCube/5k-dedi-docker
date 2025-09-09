#!/bin/sh
set -eu

if [ -z "${1-}" ]; then
	echo "entrypoint_root.sh: require arguments \$1."
	exit 1
fi

if [ "$1" != "yes" ] && [ "$1" != "force" ] && [ "$1" != "no" ]; then
	echo "entrypoint_root.sh: invalid arguments \$1, use \"yes\" or \"no\"."
	exit 1
fi

if [ "$1" = "yes" ]; then
	echo "entrypoint_root.sh: chown $SRVPATH!"
	chown -R 5k:5k "$SRVPATH"
fi

if [ "$1" = "force" ]; then
	echo "entrypoint_root.sh: forced chown $SRVPATH!"
	chown -R 5k:5k "$SRVPATH" 2>/dev/null || true
fi

if [ "$1" = "no" ]; then
	echo "entrypoint_root.sh: skipping chown!"
fi

su 5k -c "entrypoint.sh $ENTRYPOINT_ARGS"
