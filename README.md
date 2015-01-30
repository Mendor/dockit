Just-for-fun implementation of the shell access service based on unique Docker containers. Tested with Ubuntu 14.04 LTS as host system and Docker 1.0.1.

## Installation

All the commands should be run under root system account.
```shell
apt-get install docker.io git sudo
cd /root
git clone https://github.com/Mendor/dockit.git dockit
cd dockit
cp Dockerfile.source /etc/
ln -s /etc/Dockerfile.source Dockerfile
cp dockit.sh /usr/local/bin/dockit
chmod 755 /usr/local/bin/dockit
```

And add the followinf line to ``sudoers`` file using ``visudo``:
```
%users  ALL=(ALL) NOPASSWD: /usr/bin/docker
```

## Operation

To add new user named *unknown*:
```
./adduser.sh unknown
```

If you need to provide the other shell except bash for the specific user, edit ``Dockerfile``.

Unfortunately, the option ``--ephemeral`` to run self-destructing containers has been removed from Docker, so you need to use ``graveyard.sh`` script to delete the containers left from the previous sessions. May be added to the ``crontab`` file to apply cleaning on schedule.

To change the software list provided with the every container edit ``/etc/Dockerfile.source`` file.

## Does it work?

```shell
[inori] ~ % ssh nerine@akagi
Last login: Fri Jan 30 22:16:28 2015 from ***
nerine@3745a0f4cbc0:~$ ls -lah
# note the hostname
total 32K
drwxr-xr-x 4 nerine nerine 4.0K Jan 30 22:16 .
drwxr-xr-x 9 root   root   4.0K Jan 30 22:15 ..
-rw------- 1 nerine nerine  589 Jan 30 22:17 .bash_history
-rw-r--r-- 1 nerine nerine  220 Jan 30 16:42 .bash_logout
-rw-r--r-- 1 nerine nerine 3.6K Jan 30 16:42 .bashrc
drwx------ 2 nerine nerine 4.0K Jan 30 18:04 .cache
-rw-r--r-- 1 nerine nerine  675 Jan 30 16:42 .profile
drwxr-xr-x 2 nerine nerine 4.0K Jan 30 22:17 .ssh
nerine@3745a0f4cbc0:~$ touch we-were-here
# we create an empty file to check is the home directory content being kept
nerine@3745a0f4cbc0:~$ exit
Connection to akagi closed.
# ...and leave the shell
[inori] ~ % ssh nerine@akagi
Last login: Fri Jan 30 22:17:28 2015 from ***
nerine@acd523cbfea6:~$ ls -lah
# see, the hostname has been changed! This isn't the same container we were in before
total 32K
drwxr-xr-x 4 nerine nerine 4.0K Jan 30 22:18 .
drwxr-xr-x 9 root   root   4.0K Jan 30 22:15 ..
-rw------- 1 nerine nerine  616 Jan 30 22:18 .bash_history
-rw-r--r-- 1 nerine nerine  220 Jan 30 16:42 .bash_logout
-rw-r--r-- 1 nerine nerine 3.6K Jan 30 16:42 .bashrc
drwx------ 2 nerine nerine 4.0K Jan 30 18:04 .cache
-rw-r--r-- 1 nerine nerine  675 Jan 30 16:42 .profile
drwxr-xr-x 2 nerine nerine 4.0K Jan 30 22:17 .ssh
-rw-r--r-- 1 nerine nerine    0 Jan 30 22:18 we-were-here
# it is here!
nerine@acd523cbfea6:~$
```
