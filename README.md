[![Docker Pulls](https://img.shields.io/docker/pulls/jcivitell/garrysmod)](https://hub.docker.com/r/jcivitell/garrysmod) [![Docker Stars](https://img.shields.io/docker/stars/jcivitell/garrysmod)](https://hub.docker.com/r/jcivitell/garrysmod) [![Docker Image Size](https://img.shields.io/docker/image-size/jcivitell/garrysmod/latest)](https://hub.docker.com/r/jcivitell/garrysmod)


# What is Garry's Mod?
Garry's Mod, a sandbox game developed by Facepunch Studios and published by Valve in 2006, offers players an open world to manipulate objects without set objectives. Additional game modes like Trouble in Terrorist Town and Prop Hunt, created by other developers as mods, can be added through platforms like the Steam Workshop.
This Docker image contains the dedicated server of the game.


<a href="https://store.steampowered.com/app/4000/Garrys_Mod/"><img src="https://cdn.cloudflare.steamstatic.com/steam/apps/4000/header.jpg?t=1698777053" alt="logo" width="400"/></img></a>

---

# How to use this image
## Setting up game server

**Running a Garry's Mod dedicated server**

1. Run using a bind mount for data persistence on container recreation. Replace the following fields before executing the command:
```console
$ mkdir -p $(pwd)/gm-data
$ chmod 777 $(pwd)/gm-data # Makes sure the directory is writeable by the unprivileged container user
$ docker run -d --net=host \
    -v $(pwd)/gm-data:/home/steam/gm-dedicated/ \
    --name=gm-dedicated jcivitell/garrysmod
```

**The container will automatically update the game on startup, so if there is a game update just restart the container.**

# Configuration
## Environment Variables
Feel free to overwrite these environment variables, using -e (--env):
```dockerfile
GM_SERVERNAME="changeme"   (Set the visible name for your private server)
GM_PORT=27015              (GM server listen port tcp_udp)
GM_PW="changeme"           (GM server password)
GM_LOCATION=eu             (Country Flag)
GM_STEAMTOKEN="changeme"   (GSLT-Key https://steamcommunity.com/dev/managegameservers)
```

# Contributors
[![Contributors Display](https://badges.pufler.dev/contributors/jcivitel/garrysmod?size=50&padding=5&bots=false)](https://github.com/jcivitel/garrysmod/graphs/contributors)
