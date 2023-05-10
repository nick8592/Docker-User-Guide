# Docker-User-Guide

## Docker
[Installing Docker from the Default Repositories (Option 2)](https://phoenixnap.com/kb/install-docker-on-ubuntu-20-04)    
[進入容器 - 《Docker —— 從入門到實踐》正體中文版](https://philipzheng.gitbook.io/docker_practice/)   
[Docker 基本指令操作](https://ithelp.ithome.com.tw/articles/10186431)
[Docker 實戰系列（一）：一步一步帶你 dockerize 你的應用](https://larrylu.blog/step-by-step-dockerize-your-app-ecd8940696f4)

Windows search
```
cmd
```
Type in
```
wsl
```
## Docker
Create new container
```
(default)
docker run -i -t [images]
(run in background)
docker run -d [images]
```
Check container
```
(list active container)
docker ps
(list all containers)
docker ps -a
```
Remove container
```
docker rm [container id]
```
Start container
```
docker start -i [container id]
```
## Example
Create `<workspace_folder>`   
Put code in `<workspace_folder>`   
Create new code called `Dockerfile`   
```
<workspace_folder>
├── Dockerfile   <--   這裡
├── README.md
└── main,py
```
Base on you environment defined `Dockerfile` code   
```
(For example)
FROM python
COPY main.py /main/
WORKDIR /main
RUN apt-get update && apt-get -y upgrade
RUN pip install numpy
CMD python main.py
```
Open CMD   
Get into `<workspace_folder>`
Build your own image.   
Type in   
```
docker build -t <workspace_folder> .
```
Check new docker image created   
```
docker images
```
Run your own image
```
docker run <workspace_folder>
```
Push image
```
docker tag docker/welcome-to-docker YOUR-USERNAME/welcome-to-docker
```
### Docker Run
https://docs.docker.com/engine/reference/commandline/run/

### Container connet to local folder
https://docs.docker.com/storage/bind-mounts/   
windows path conversion https://docs.docker.com/desktop/troubleshoot/topics/  
```
<method 1> use -v
docker run -it --name <container_name> -v <local_folder>:<container_folder> --gpus all -u 0 --shm-size 12G <image_id> bash
(e.g.) docker run -it --name test111 -v C:\Users\user\Desktop\mmlab\code\test:/main --gpus all -u 0 --shm-size 12G test bash

<method 2> use --mount
docker run -it --name <container_name> --mount type=bind,source=<local_folder>,target=<container_folder> --gpus all -u 0 --shm-size 12G <image_id> bash
(e.g.) docker run -it --name mount_test --mount type=bind,source=C:\Users\user\Desktop\mmlab\code\test,target=/main --gpus all -u 0 --shm-size 12G test bash
```
