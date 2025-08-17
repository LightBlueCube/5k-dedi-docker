#!/bin/sh
set -eu

if [ -z "${1-}" ]; then
	echo "entrypoint.sh: require arguments \$1."
	exit 1
elif [ "$1" = "native" ]; then
	"${STEAMPATH}/steamcmd.sh" @ShutdownOnFailedCommand @NoPromptForPassword +force_install_dir "$SRVPATH" +login anonymous +app_update $APPID +quit
elif [ "$1" = "wine" ]; then
	"${STEAMPATH}/steamcmd.sh" @ShutdownOnFailedCommand @NoPromptForPassword +@sSteamCmdForcePlatformType windows +force_install_dir "$SRVPATH" +login anonymous +app_update $APPID +quit
elif [ "$1" = "skip" ]; then
	echo "entrypoint.sh: skipping steamcmd!"
else
	echo "entrypoint.sh: invalid arguments \$1, use \"native\" or \"wine\" or \"skip\"."
	exit 1
fi

cd "$SRVPATH"

if [ -n "$STARTENV" ]; then
	export $STARTENV
fi

if [ -n "${2-}" ]; then
	if [ "${2-}" != "skip" ]; then
		echo "entrypoint.sh: invalid arguments \$2, leave undefined or use \"skip\"."
		exit 1
	fi

	$STARTCMD $ARGS
	exit
fi

echo "entrypoint.sh: activate log checker!"

pipe=$(mktemp -u)
mkfifo $pipe
$STARTCMD $ARGS > $pipe &
SRV_PID=$!
SHELL_PID=$$

MATCH_TARGET="FOnlineAsyncTaskSteamCreateServer bWasSuccessful: 0
Error: SteamSockets API"

(while IFS= read -r line; do
	printf '%s\n' "$line"

	while IFS=$(printf '\n') read -r TARGET; do
		if ! echo "$line" | grep -q "$TARGET"; then
			continue
		fi

		echo "\n======== entrypoint.sh ========\nentrypoint.sh: detected \"$TARGET\", exiting!\n================================"
		kill "$SRV_PID"
		kill "$SHELL_PID"
	done <<EOF
$MATCH_TARGET
EOF

done < $pipe) &

wait "$SRV_PID"
kill "$SHELL_PID"
