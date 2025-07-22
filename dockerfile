FROM debian

RUN apt update && apt install -y lib32gcc-s1 curl && rm -rf /var/lib/apt/lists/* && \
	useradd -m -s /bin/bash 5k

ENV STEAMPATH="/home/5k/Steam"

USER 5k
RUN mkdir ${STEAMPATH} && cd ${STEAMPATH} && \
	curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf - && \
	./steamcmd.sh +'quit'

ENV APPID=884110
ENV SRVPATH="/home/5k/Steam/steamapps/common/SCP Pandemic Dedicated Server"

CMD ${STEAMPATH}/steamcmd.sh @ShutdownOnFailedCommand @NoPromptForPassword +login anonymous +app_update ${APPID} validate +'quit' && \
	cd "${SRVPATH}" && ./LinuxServer/PandemicServer.sh
