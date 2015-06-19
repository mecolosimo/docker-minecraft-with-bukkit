# docker-minecraft-with-bukkit

A Minecraft multiplayer server with Bukkit running in a Docker container. For help
on getting started with docker see the [official getting started guide][0]. For
more information on Minecraft and check out it's [website][1].

## Running

   create a directory to mount to

      mkdir minecraft

   then build and run::

     docker build -t mecolosimo/craftbukkit .
     docker run -d -p 22 -p 25565:25565 -v /home/${USER}/minecraft:/mnt/minecraft --name bukkit mecolosimo/craftbukkit 

