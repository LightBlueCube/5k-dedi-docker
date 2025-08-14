# SCP-5K Dedicated Server For Docker

## Usage

> The text under "<>" meanning you have to replace it by youself according to your needs, and delete "<>"

We currently have two different implementations, you need to choose one according you needs

**Native**: A simple setup by using native linux server, choose this if you have no idea about which option to pick

**Wine**: Runs windows version of server by using wine, made for people who want use `UE4SS`

[For people who just want quickly host a server](#quick-start)

[For people who want know more about this](#advanced)

[让我们说中文 | For people who not a english speaker](#使用方法)

## Quick Start

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

You have to create a volume for stoagre your server files, mount it on `${SRVPATH}` (see ENVs on below)

| ENVs      	| Native 	| Wine 	| Default Value                                                 	| Description                                                                                                                   	|
|-----------	|--------	|------	|---------------------------------------------------------------	|-------------------------------------------------------------------------------------------------------------------------------	|
| APPID     	| YES    	| YES  	| 884110                                                        	| Game server's steam appid                                                                                                     	|
| STEAMPATH 	| YES    	| YES  	| "/home/5k/Steam"                                              	| Steamcmd path                                                                                                                 	|
| SRVPATH   	| YES    	| YES  	| "${STEAMPATH}/steamapps/common/SCP Pandemic Dedicated Server" 	| Game server path                                                                                                              	|
| ARGS      	| YES    	| YES  	| ""                                                            	| The params you want sent to the server                                                                                        	|
| STARTENV  	| NO     	| YES  	| "WINEDLLOVERRIDES=dwmapi=native,builtin"                      	| Start environments, if you want running vanilla server but failed to starting, try clean it (**may cause `UE4SS` not loading**) 	|
| STARTCMD  	| NO     	| YES  	| "wine ./WindowsServer/PandemicServer.exe"                     	| Start command, used for start server, you can change it according you needs.<br/>For example: `"wine ./StartServer.bat"`      	|

----

### 使用方法

> "<>"内的文字需要你根据你的需求自行替换，并删掉"<>"

我们目前有两种不同的实现，根据你的需求选择一个

**Native**: 一个跑原生linux服务器的简单实现，如果你不知道选哪个，选这个

**Wine**: 使用wine来跑windows的服务器，为那些想要使用`UE4SS`的人制作

[对于那些只是想快速搭建一个服务器的人](#快速开始)

[对于那些想要了解更多的人](#高级)


## 快速开始

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

你需要创建一个volume存储你的服务器文件，并挂载在`${SRVPATH}`(参阅下方ENVs)

| ENVs      	| Native 	| Wine 	| 默认值                                                         	| 描述                                                                           	|
|-----------	|--------	|------	|---------------------------------------------------------------	|-------------------------------------------------------------------------------	|
| APPID     	| YES    	| YES  	| 884110                                                        	| 游戏服务器的steam appid                                                         	|
| STEAMPATH 	| YES    	| YES  	| "/home/5k/Steam"                                              	| steamcmd的路径                                                                 	|
| SRVPATH   	| YES    	| YES  	| "${STEAMPATH}/steamapps/common/SCP Pandemic Dedicated Server" 	| 游戏服务器的路径                                                                 	|
| ARGS      	| YES    	| YES  	| ""                                                            	| 你想发给服务器的参数                                                              	|
| STARTENV  	| NO     	| YES  	| "WINEDLLOVERRIDES=dwmapi=native,builtin"                      	| 环境变量，如果你想开原版服务器并在启动时遇到问题，尝试覆写为空（**可能会导致`UE4SS`不工作**） 	|
| STARTCMD  	| NO     	| YES  	| "wine ./WindowsServer/PandemicServer.exe"                     	| 用于开启服务器的指令，你可以根据你的需要更改<br/>举例： `"wine ./StartServer.bat"`     	|
