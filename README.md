# Docker-User-Guide

## Downloads
[Docker for Windows / Linux](https://www.docker.com/)  
[OrbStack for Mac](https://orbstack.dev/)   

## Links
[Installing Docker from the Default Repositories (Option 2)](https://phoenixnap.com/kb/install-docker-on-ubuntu-20-04)    
[進入容器 - 《Docker —— 從入門到實踐》正體中文版](https://philipzheng.gitbook.io/docker_practice/)   
[Docker 基本指令操作](https://ithelp.ithome.com.tw/articles/10186431)
[Docker 實戰系列（一）：一步一步帶你 dockerize 你的應用](https://larrylu.blog/step-by-step-dockerize-your-app-ecd8940696f4)

## Installation Guide
### Install Docker Engine on Ubuntu
Run the following command to uninstall all conflicting packages:
```bash
 for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
```
Set up Docker's `apt` repository.
```bash
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```
Install the Docker packages.
```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```
Verify that the Docker Engine installation is successful by running the hello-world image.
```bash
sudo docker run hello-world
```

### Install Docker Desktop on Ubuntu
For non-Gnome Desktop environments, gnome-terminal must be installed:
```bash
sudo apt install gnome-terminal
```
Download latest [DEB package](https://docs.docker.com/desktop/install/ubuntu/).
Install the package with apt as follows:
```bash
sudo apt-get update
sudo apt-get install ./docker-desktop-<version>-<arch>.deb
```


### Installing the NVIDIA Container Toolkit
#### Installing with Apt
Configure the production repository:
```bash
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
```
Update the packages list from the repository:
```bash
sudo apt-get update
```
Install the NVIDIA Container Toolkit packages:
```bash
sudo apt-get install -y nvidia-container-toolkit
```


## Basic
Create new container
```bash
(default)
docker run -i -t [images]
(run in background)
docker run -d [images]
```
Check container
```bash
(list active container)
docker ps
(list all containers)
docker ps -a
```
Start container
```bash
docker start -i [container id]
```
Remove container
```bash
docker rm [container id]
```


## Run
https://docs.docker.com/engine/reference/commandline/run/

## Easy Example
Create `<workspace_folder>`   
Put code in `<workspace_folder>`   
Create new code called `Dockerfile`   
```
<workspace_folder>
├── Dockerfile   <--   這裡
├── README.md
└── main.py
```
Base on you environment defined `Dockerfile` code   
```Dockerfile
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
```bash
docker build -t <workspace_folder> .
```
Check new docker image created   
```bash
docker images
```
Run your own image
```bash
docker run <workspace_folder>
```
Push image
```bash
docker tag docker/welcome-to-docker YOUR-USERNAME/welcome-to-docker
```

## Container connet to local folder
**DO NOT OPEN `WSL`** on windows terminal, it will cause error `docker: Error response from daemon`  
https://docs.docker.com/storage/bind-mounts/   
windows path conversion https://docs.docker.com/desktop/troubleshoot/topics/  
- Remember to set `--gpus all` if you need to use GPU.   
```bash
<method 1> use -v
docker run -it --name <container_name> -v <local_folder>:<container_folder> --gpus all -u 0 --shm-size 12G <image_id> bash
(windows) docker run -it --name test111 -v C:\Users\user\Desktop\mmlab\code\test:/main --gpus all -u 0 --shm-size 12G test bash
(linux/mac) docker run -it --name kmeans -v /User/weichenpai/Code/Kmeans-Clustering:/Kmeans 3f5ef9003cef bash

<method 2> use --mount
docker run -it --name <container_name> --mount type=bind,source=<local_folder>,target=<container_folder> --gpus all -u 0 --shm-size 12G <image_id> bash
(windows) docker run -it --name mount_test --mount type=bind,source=C:\Users\user\Desktop\mmlab\code\test,target=/main --gpus all -u 0 --shm-size 12G test bash
```

## Errors
- [docker环境里安装opencv ImportError: libGL.so.1: cannot open shared object file: No such file or directory](https://blog.csdn.net/Max_ZhangJF/article/details/108920050)
```bash
<error message>
ImportError: libGL.so.1: cannot open shared object file: No such file or directory
<solution>
pip uninstall opencv-python
pip install opencv-python-headless
```

## For MacOS
[Docker command not found when running on Mac](https://stackoverflow.com/a/76097028).  
Add your Docker binary path
```bash
export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"
```
Then reload the configuration & test with:
```bash
source ~/.bash_profile && docker --version
```
[Mac zsh: command not found: docker](https://blog.csdn.net/qq_45296221/article/details/122191265).  
Find `docker` command path, for example:
```bash
/Applications/Docker.app/Contents/Resources/bin
```
Edit PATHs file, use `i` insert
```bash
sudo vim /etc/paths
```
Add `docker` path into PATHs file
```
/usr/local/bin
/System/Cryptexes/App/usr/bin
/usr/bin
/bin
/usr/sbin
/sbin

# docker
/Applications/Docker.app/Contents/Resources/bin
```
Use `:wq` save & exit, complete adding path.   

[Fixing the ‘Mounts denied’ error in Docker for Mac v2.2.3](https://medium.com/effy-tech/fixing-the-var-folders-error-in-docker-for-mac-v2-2-3-2a40e776132d).  
The solution is to manually edit the configuration file for your docker installation. 
```bash
cd Library/Group\ Containers/group.com.docker/
```
Edit `settings.json`
```bash
sudo vim settings.json
```
Find below section:   
```
"filesharingDirectories": [
    "/Users",
    "/Volumes",
    "/private",
    "/tmp",
    "/var/folders"
  ],
```
Add path you want to add, for exampple :`"/Users/<yours_username>/Code"`.  
```
"filesharingDirectories": [
    "/Users",
    "/Volumes",
    "/private",
    "/tmp",
    "/var/folders",
    "/Users/<yours_username>/Code"
  ],
```
Save the file and exit, `:wq`. Now restart your Docker.   
[File system sharing (osxfs)](https://docs.docker.com.zh.xy2401.com/v17.09/docker-for-mac/osxfs/#access-control)
