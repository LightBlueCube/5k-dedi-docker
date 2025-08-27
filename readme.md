# SCP-5K Dedicated Server For Docker

## Usage

We currently have two different implementations, you need to choose one according you needs

**Native**: A simple setup by using native linux server, choose this if you have no idea about which option to pick

**Wine**: Runs windows version of server by using wine, made for people who want use `UE4SS`

[For people who just want quickly host a server](#quick-start)

[For people who not a newbie to docker and linux](#advanced)

[让我们说中文](#使用方法)

## Quick Start

> The text under "<>" meanning you have to replace it by youself according to your needs, and delete "<>"

### Step 1

Pull docker image

#### Native

```bash
docker pull ghcr.io/lightbluecube/5k-dedi-docker/5k-dedi:latest
```
#### Wine

```bash
docker pull ghcr.io/lightbluecube/5k-dedi-docker/5k-dedi-wine:latest
```

### Step 2

Create a volume for storage your server files

```bash
docker volume create <1>
```

**1**: Any name for volume

You can access your server files later at `/var/lib/docker/volumes/<volume_name>/_data/`

### Step 3

Enter command to start your server

```bash
docker run --name <1> -p <2>:<2>/<3> <4> -e ARGS="<5>" -v <6>:"/home/5k/Steam/steamapps/common/SCP Pandemic Dedicated Server" <7>
```

**1**: Any name for container

**2**: Port number

**3**: Type `tcp` or `udp`

**4**: Add muiltple `-p <2>:<2>/<3>` for forwarding muiltple ports

**5**: Params you want send to the server, leave empty if you dont wanna send any params

**6**: The volume name you just created

**7**: Image name

Image name of **Native**: `ghcr.io/lightbluecube/5k-dedi-docker/5k-dedi`

Image name of **Wine**: `ghcr.io/lightbluecube/5k-dedi-docker/5k-dedi-wine`

----

Example:

```bash
docker run --name scp5kserver -p 7777:7777/tcp -p 7777:7777/udp -p 27015:27015/tcp -p 27015:27015/udp -e ARGS="M_Sewer_CanalPVP -maprotation=M_Sewer_CanalPVP" -v 5k_volume:"/home/5k/Steam/steamapps/common/SCP Pandemic Dedicated Server" ghcr.io/lightbluecube/5k-dedi-docker/5k-dedi
```

Add `-d` if you want it running on background

<br/>

## Advanced

You have to create a volume for stoagre your server files, mount it on `$SRVPATH` (see [ENVs](#envs))

### ENVs

| ENVs               	| Default Value                                                                                     	| Description                                                                           	|
|--------------------	|---------------------------------------------------------------------------------------------------	|---------------------------------------------------------------------------------------	|
| APPID              	| `884110`                                                                                          	| Game server's steam appid                                                             	|
| STEAMPATH          	| `"/home/5k/Steam"`                                                                                	| Steamcmd path                                                                         	|
| SRVPATH            	| `"${STEAMPATH}/steamapps/common/SCP Pandemic Dedicated Server"`                                   	| Game server path                                                                      	|
| ARGS               	| `""`                                                                                              	| The params you want sent to the server                                                	|
| STARTENV           	| Native: `""`<br/>Wine: `"WINEDLLOVERRIDES=dwmapi=native,builtin"`                                 	| Start environments, **modify `WINEDLLOVERRIDES` may result in `UE4SS` not loading**   	|
| STARTCMD           	| Native: `"./LinuxServer/PandemicServer.sh"`<br/>Wine: `"wine ./WindowsServer/PandemicServer.exe"` 	| Start command, used to start the server, a modify example: `"wine ./StartServer.bat"` 	|
| ENTRYPOINT_ARGS    	| Native: `"native no no"`<br/>Wine: `"wine no no"`                                                 	| Params for entrypoint.sh, see [Entrypoint Params](#entrypoint-params)                 	|
| UE4SS_LOG_SRC_PATH 	| Native: undefined<br/>Wine: `"${SRVPATH}/WindowsServer/Pandemic/Binaries/Win64/ue4ss"`            	| Used by [UE4SS Log Clipper](#ue4ss-log-clipper)                                       	|
| UE4SS_LOG_TO_PATH  	| Native: undefined<br/>Wine: `"${UE4SS_LOG_SRC_PATH}/logs"`                                        	| Used by [UE4SS Log Clipper](#ue4ss-log-clipper)                                       	|

### Entrypoint Params

| Params 	| Allowed value            	| Description                                                                 	|
|--------	|--------------------------	|-----------------------------------------------------------------------------	|
| $1     	| `native`, `wine`, `skip` 	| Used to set steamcmd's platform type, `skip` to skip the steamcmd           	|
| $2     	| `yes`, `no`              	| Used to should start [UE4SS Log Clipper](#ue4ss-log-clipper), **Wine ONLY** 	|
| $3     	| `yes`, `no`              	| Used to should [Reset Wine](#reset-wine) before starting, **Wine ONLY**     	|
| $4     	| `yes`, `no`              	| Used to should start [Log Checker](#log-checker)                            	|

Example:

```sh
-e ENTRYPOINT_ARGS="native no no yes"
```

Use linux platform, not start UE4SS Log Clipper, no Reset Wine, start Log Checker

```sh
-e ENTRYPOINT_ARGS="wine yes yes yes"
```

Use windows platform, start UE4SS Log Clipper, Reset Wine, start Log Checker

```sh
-e ENTRYPOINT_ARGS="skip no no no"
```

Skip steamcmd, not start UE4SS Log Clipper, no Reset Wine, not start Log Checker

### UE4SS Log Clipper

A simple script will clip `$UE4SS_LOG_SRC_PATH/UE4SS.log` to `$UE4SS_LOG_TO_PATH` everytime before server starting

The name format of the log: `$(date +"%Y%m%dT%H%M%S%z").log`

### Reset Wine

A simple script will `rm -rf /home/5k/.wine` everytime before server starting

### Log Checker

A simple script will keep watching the stdout, and if it find any matched strings, it will kill the server

Default matched strings: `FOnlineAsyncTaskSteamCreateServer bWasSuccessful: 0`, `SteamSockets API: Error`

You can modify it in `entrypoint.sh` > `$MATCH_TARGET`

----

### 使用方法

我们目前有两种不同的实现，根据你的需求选择一个

**Native**: 一个跑原生linux服务端的简单实现，如果你不知道选哪个，选这个

**Wine**: 使用wine来跑windows服务端，为那些想要使用`UE4SS`的人制作

[对于那些只是想快速搭建一个服务器的人](#快速开始)

[对于那些对Docker和Linux不是新手的人](#高级)


## 快速开始

> "<>"内的文字需要你根据你的需求自行替换，并删掉"<>"

### Step 1

拉取镜像

#### Native

```bash
docker pull ghcr.io/lightbluecube/5k-dedi-docker/5k-dedi:latest
```
#### Wine

```bash
docker pull ghcr.io/lightbluecube/5k-dedi-docker/5k-dedi-wine:latest
```

### Step 2

创建一个volume用于存储你的服务器文件

```bash
docker volume create <1>
```

**1**: 为你的volume取一个名字

你可以稍后在 `/var/lib/docker/volumes/<volume_name>/_data/` 访问你的服务器文件

### Step 3

使用这个指令启动你的服务器

```bash
docker run --name <1> -p <2>:<2>/<3> <4> -e ARGS="<5>" -v <6>:"/home/5k/Steam/steamapps/common/SCP Pandemic Dedicated Server" <7>
```

**1**: 为你的container取一个名字

**2**: 端口号

**3**: 填`tcp`或`udp`

**4**: 增加多个`-p <2>:<2>/<3>`来转发更多端口

**5**: 传递给服务器的参数，如果你不想传递任何参数，留空

**6**: 你刚刚创建的volume名

**7**: 镜像名

**Native**的镜像名: `ghcr.io/lightbluecube/5k-dedi-docker/5k-dedi`

**Wine**的镜像名: `ghcr.io/lightbluecube/5k-dedi-docker/5k-dedi-wine`

----

示例:

```bash
docker run --name scp5kserver -p 7777:7777/tcp -p 7777:7777/udp -p 27015:27015/tcp -p 27015:27015/udp -e ARGS="M_Sewer_CanalPVP -maprotation=M_Sewer_CanalPVP" -v 5k_volume:"/home/5k/Steam/steamapps/common/SCP Pandemic Dedicated Server" ghcr.io/lightbluecube/5k-dedi-docker/5k-dedi
```

如果你希望运行在后台，加 `-d`

<br/>

## 高级

你需要创建一个volume存储你的服务器文件，并挂载在`$SRVPATH`(参阅[ENVs](#envs-1))

### ENVs

| ENVs               	| 默认值                                                                                             	| 描述                                                              	|
|--------------------	|---------------------------------------------------------------------------------------------------	|------------------------------------------------------------------	|
| APPID              	| `884110`                                                                                          	| 游戏服务器的steam appid                                            	|
| STEAMPATH          	| `"/home/5k/Steam"`                                                                                	| steamcmd的路径                                                    	|
| SRVPATH            	| `"${STEAMPATH}/steamapps/common/SCP Pandemic Dedicated Server"`                                   	| 游戏服务器的路径                                                    	|
| ARGS               	| `""`                                                                                              	| 你想发给服务器的参数                                                	|
| STARTENV           	| Native: `""`<br/>Wine: `"WINEDLLOVERRIDES=dwmapi=native,builtin"`                                 	| 环境变量，**修改`WINEDLLOVERRIDES`可能会导致`UE4SS`不加载**           	|
| STARTCMD           	| Native: `"./LinuxServer/PandemicServer.sh"`<br/>Wine: `"wine ./WindowsServer/PandemicServer.exe"` 	| 用于启动服务器的指令，修改例： `"wine ./StartServer.bat"`             	|
| ENTRYPOINT_ARGS    	| Native: `"native no no"`<br/>Wine: `"wine no no"`                                                 	| entrypoint.sh的参数，详见[Entrypoint Params](#entrypoint-params-1) 	|
| UE4SS_LOG_SRC_PATH 	| Native: undefined<br/>Wine: `"${SRVPATH}/WindowsServer/Pandemic/Binaries/Win64/ue4ss"`            	| 被用于 [UE4SS Log Clipper](#ue4ss-log-clipper-1)                  	|
| UE4SS_LOG_TO_PATH  	| Native: undefined<br/>Wine: `"${UE4SS_LOG_SRC_PATH}/logs"`                                        	| 被用于 [UE4SS Log Clipper](#ue4ss-log-clipper-1)                  	|

### Entrypoint Params

| Params 	| 合法值                    	| 描述                                                              	|
|--------	|--------------------------	|------------------------------------------------------------------	|
| $1     	| `native`, `wine`, `skip` 	| 用于设置steamcmd的平台类型，`skip`为跳过steamcmd                     	|
| $2     	| `yes`, `no`              	| 用于是否启用[UE4SS Log Clipper](#ue4ss-log-clipper-1)，**仅限Wine** 	|
| $3     	| `yes`, `no`              	| 用于是否[Reset Wine](#reset-wine-1)在服务器启动之前, **仅限Wine**       	|
| $4     	| `yes`, `no`              	| 用于是否启用[Log Checker](#log-checker-1)                          	|

示例:

```sh
-e ENTRYPOINT_ARGS="native no no yes"
```

使用linux平台，不启动UE4SS Log Clipper，不Reset Wine，启动Log Checker

```sh
-e ENTRYPOINT_ARGS="wine yes yes yes"
```

使用windows平台，启动UE4SS Log Clipper，Reset Wine，启动Log Checker

```sh
-e ENTRYPOINT_ARGS="skip no no no"
```

跳过steamcmd，不启动UE4SS Log Clipper，不Reset Wine，不启动Log Checker

### UE4SS Log Clipper

一个简单的脚本，会在每次服务器运行前复制`$UE4SS_LOG_SRC_PATH/UE4SS.log`到`$UE4SS_LOG_TO_PATH`

日志的命名格式: `$(date +"%Y%m%dT%H%M%S%z").log`

### Reset Wine

一个简单的脚本，会在每次服务器运行前`rm -rf /home/5k/.wine`

### Log Checker

一个简单的脚本，会持续监听标准输出(stdout)，如果发现匹配的字符串，就会杀掉服务器

默认匹配字符串：`FOnlineAsyncTaskSteamCreateServer bWasSuccessful: 0`, `SteamSockets API: Error`

你可以在`entrypoint.sh` > `$MATCH_TARGET`修改
