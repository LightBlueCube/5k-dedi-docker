#!/bin/sh
set -eu

# SteamCMD

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

# Setup environments

cd "$SRVPATH"

if [ -n "$STARTENV" ]; then
	export $STARTENV
fi

# UE4SS Log Clipper

if [ -z "${2-}" ]; then
	echo "entrypoint.sh: require arguments \$2."
	exit 1
fi

if [ "$2" != "yes" ] && [ "$2" != "no" ]; then
	echo "entrypoint.sh: invalid arguments \$2, use \"yes\" or \"no\"."
	exit 1
fi

if [ "$2" = "yes" ]; then
	echo "entrypoint.sh: clipping UE4SS.log!"
	mkdir -p "$UE4SS_LOG_TO_PATH"
	cp "$UE4SS_LOG_SRC_PATH/UE4SS.log" "$UE4SS_LOG_TO_PATH/$(date +"%Y%m%dT%H%M%S%z").log"
fi

# Reset Wine

if [ -z "${3-}" ]; then
	echo "entrypoint.sh: require arguments \$3."
	exit 1
fi


if [ "$3" != "yes" ] && [ "$3" != "no" ]; then
	echo "entrypoint.sh: invalid arguments \$3, use \"yes\" or \"no\"."
	exit 1
fi

if [ "$3" = "yes" ]; then
	echo "entrypoint.sh: reseting wine!"
	rm -rf /home/5k/.wine
fi

# Log Checker

if [ -z "${4-}" ]; then
	echo "entrypoint.sh: require arguments \$4."
	exit 1
fi


if [ "$4" != "yes" ] && [ "$4" != "no" ]; then
	echo "entrypoint.sh: invalid arguments \$4, use \"yes\" or \"no\"."
	exit 1
fi

if [ "$4" = "no" ]; then
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
SteamSockets API: Error"

(while IFS= read -r line; do
	printf '%s\n' "$line"

	while IFS=$(printf '\n') read -r TARGET; do
		if ! echo "$line" | grep -q "$TARGET"; then
			continue
		fi

		echo "\n======== entrypoint.sh ========\nentrypoint.sh: detected \"$TARGET\", exiting!\n================================"
		rm -f $pipe
		kill "$SRV_PID"
		kill "$SHELL_PID"
		exit
	done <<EOF
$MATCH_TARGET
EOF

done < $pipe) &

wait "$SRV_PID"
rm -f $pipe
kill "$SHELL_PID"
