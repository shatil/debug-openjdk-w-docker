#!/usr/bin/env sh
# Generic entrypoint.sh for all containers.
set -ex
trap 'echo "Client shutting down" && exit' INT TERM

pacman=exit
if [ -x /sbin/apk ] ; then
    pacman='apk --no-cache add'
elif [ -x /usr/bin/yum ]; then
    # Amazon Linux (Yum-based) doesn't have an OpenJDK image.
    pacman='yum -y install java-1.8.0-openjdk-headless'
elif [ -x /usr/bin/apt-get ]; then
    apt-get update
    pacman='apt-get -y install'
fi
$pacman bash curl openssl rsync

# Clients won't have /svc. Play writes to this directory, so copy it.
if [ -x /svc/bin/start ] ; then
    rsync -a /svc/ /mysvc/
fi

if [ -x /mysvc/bin/start ] ; then
    exec /mysvc/bin/start -Dhttps.port=9443 -Dplay.crypto.secret=secret
else
    while echo Client sleeping... ; do sleep 300 ; done
fi
