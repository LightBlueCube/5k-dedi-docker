# SCP-5K Dedicated Server For Docker

### Usage

> The text under "<>" meanning you have to replace it by youself according to your needs, and delete "<>"

#### Step 1

Pull docker image

```bash
docker pull ghcr.io/lightbluecube/5k-dedi-docker/5k-dedi:latest
```

Add `sudo` before the command if you arent root user

#### Step 2

Create a volume for storage your server files

```bash
docker volume create <any_name>
```

Add `sudo` before the command if you arent root user

You can access your server files later at `/var/lib/docker/volumes/<volume_name>/_data/`

#### Step 3

Enter command to start your server

```bash
docker run --name <any_name> -p <port>:<port> -v <the_volume_you_just_created>:"/home/5k/Steam/steamapps/common/SCP Pandemic Dedicated Server" ghcr.io/lightbluecube/5k-dedi-docker/5k-dedi
```

Add `sudo` before the command if you arent root user

Add `-d` if you want it running on background

### 使用方法

> "<>"内的文字需要你根据你的需求自行替换，并删掉"<>"

#### Step 1

拉取镜像

```bash
docker pull ghcr.io/lightbluecube/5k-dedi-docker/5k-dedi:latest
```

如果你不是以root用户运行，在命令前加 `sudo`

#### Step 2

创建一个volume用于存储你的服务器文件

```bash
docker volume create <任何名字>
```

如果你不是以root用户运行，在命令前加 `sudo`

你可以稍后在 `/var/lib/docker/volumes/<volume_name>/_data/` 访问你的服务器文件

#### Step 3

使用这个指令启动你的服务器

```bash
docker run --name <任何名字> -p <端口>:<端口> -v <你刚创建的volume名>:"/home/5k/Steam/steamapps/common/SCP Pandemic Dedicated Server" ghcr.io/lightbluecube/5k-dedi-docker/5k-dedi
```

如果你不是以root用户运行，在命令前加 `sudo`

如果你希望运行在后台，加 `-d`
