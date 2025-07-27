# SCP-5K Dedicated Server For Docker

### Usage

> The text under "<>" meanning you have to replace it by youself according to your needs, and delete "<>"

#### Step 1

Pull docker image

```bash
docker pull ghcr.io/lightbluecube/5k-dedi-docker/5k-dedi:latest
```

#### Step 2

Create a volume for storage your server files

```bash
docker volume create <1>
```

**1**: Any name for volume

You can access your server files later at `/var/lib/docker/volumes/<volume_name>/_data/`

#### Step 3

Enter command to start your server

```bash
docker run --name <1> -p <2>:<2>/<3> <4> -e ARGS="<5>" -v <6>:"/home/5k/Steam/steamapps/common/SCP Pandemic Dedicated Server" ghcr.io/lightbluecube/5k-dedi-docker/5k-dedi
```

**1**: Any name for container

**2**: Port number

**3**: Type `tcp` or `udp`

**4**: Add muiltple `-p <2>:<2>/<3>` for forwarding muiltple ports

**5**: Params you want send to server, leave empty if you dont wanna send any params

**6**: The volume name you just created

Example:

```bash
docker run --name scp5kserver -p 7777:7777/tcp -p 7777:7777/udp -p 27015:27015/tcp -p 27015:27015/udp -e ARGS="M_Sewer_CanalPVP -maprotation=M_Sewer_CanalPVP" -v 5k_volume:"/home/5k/Steam/steamapps/common/SCP Pandemic Dedicated Server" ghcr.io/lightbluecube/5k-dedi-docker/5k-dedi
```

Add `-d` if you want it running on background

### 使用方法

> "<>"内的文字需要你根据你的需求自行替换，并删掉"<>"

#### Step 1

拉取镜像

```bash
docker pull ghcr.io/lightbluecube/5k-dedi-docker/5k-dedi:latest
```

#### Step 2

创建一个volume用于存储你的服务器文件

```bash
docker volume create <1>
```

**1**: 为你的volume取一个名字

你可以稍后在 `/var/lib/docker/volumes/<volume_name>/_data/` 访问你的服务器文件

#### Step 3

使用这个指令启动你的服务器

```bash
docker run --name <1> -p <2>:<2>/<3> <4> -e ARGS="<5>" -v <6>:"/home/5k/Steam/steamapps/common/SCP Pandemic Dedicated Server" ghcr.io/lightbluecube/5k-dedi-docker/5k-dedi
```

**1**: 为你的container取一个名字

**2**: 端口号

**3**: 填`tcp`或`udp`

**4**: 增加多个`-p <2>:<2>/<3>`来转发更多端口

**5**: 传递给服务器的参数，如果你不想传递任何参数，留空

**6**: 你刚刚创建的volume名

示例:

```bash
docker run --name scp5kserver -p 7777:7777/tcp -p 7777:7777/udp -p 27015:27015/tcp -p 27015:27015/udp -e ARGS="M_Sewer_CanalPVP -maprotation=M_Sewer_CanalPVP" -v 5k_volume:"/home/5k/Steam/steamapps/common/SCP Pandemic Dedicated Server" ghcr.io/lightbluecube/5k-dedi-docker/5k-dedi
```

如果你希望运行在后台，加 `-d`
