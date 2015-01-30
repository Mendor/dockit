#!/bin/bash

DOCKERFILE=/etc/Dockerfile.source
USERSHELL=`grep $USER $DOCKERFILE | awk '{print $4}'`
sudo docker run -i -v /home/$USER:/home/$USER -w /home/$USER -u $USER -e "HOME=/home/$USER" -t mayoi/shell:latest $USERSHELL
