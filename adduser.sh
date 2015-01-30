#!/bin/bash

DOCKITDIR=/root/dockit
DOCKERFILE=$DOCKITDIR/Dockerfile
DOCKITSHELL=/usr/local/bin/dockit
USERGROUP=users
USERNAME=$1
TEMPLATE=mayoi/shell

# Add new user to the host system and image template
adduser $USERNAME
usermod -G $USERGROUP $USERNAME
chsh -s $DOCKITSHELL $USERNAME
ADDEDID=`id -u $USERNAME`
echo "RUN useradd -ms /bin/bash -u $ADDEDID $USERNAME" >> $DOCKERFILE

# rebuild Docker image
cd $DOCKITDIR
BUILDTAG=`date +%s`
docker build -t $TEMPLATE:$BUILDTAG .
docker tag $TEMPLATE:$BUILDTAG $TEMPLATE:latest
