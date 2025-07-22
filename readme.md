# SCP-5k Dedicated Server For Docker

### Usage

> The text under "<>" meanning you have to replace it by youself according to your needs, and delete "<>"

#### Step 1

[Pull docker image](https://github.com/LightBlueCube/5k-dedi-docker/pkgs/container/5k-dedi-docker%2F5k-dedi)

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

Add `-d` if you want it running on background

Add `sudo` before the command if you arent root user
