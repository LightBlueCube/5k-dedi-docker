FROM debian

RUN apt update && apt install -y lib32gcc-s1 curl && rm -rf /var/lib/apt/lists/* && \
	useradd -m -s /bin/bash 5k

ENV APPID=884110
ENV STEAMPATH="/home/5k/Steam"
ENV SRVPATH="/home/5k/Steam/steamapps/common/SCP Pandemic Dedicated Server"

USER 5k
RUN mkdir -p "${STEAMPATH}" "${SRVPATH}" && cd "${STEAMPATH}" && \
	curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -

CMD "${STEAMPATH}/steamcmd.sh" @ShutdownOnFailedCommand @NoPromptForPassword +login anonymous +app_update ${APPID} +'quit' && \
	cd "${SRVPATH}" && ./LinuxServer/PandemicServer.sh
