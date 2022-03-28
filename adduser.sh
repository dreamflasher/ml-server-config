#!/bin/sh

# call by: bash adduser.sh USERNAME SSH_KEY

sudo useradd -s /bin/bash -d /home/$1/ -m -G sudo $1
sudo usermod -aG sudo $1
sudo mkdir /home/$1/.ssh/
sudo chmod 0700 /home/$1/.ssh/
grep -xqF -- "$2" /home/$1/.ssh/authorized_keys || sudo -- sh -c "echo '$2' > /home/$1/.ssh/authorized_keys"
sudo chown -R $1:$1 /home/$1/.ssh/

LINE='%sudo ALL=(ALL) NOPASSWD: ALL'
grep -xqF -- "$LINE" /etc/sudoers || sudo sh -c "echo '$LINE' >> /etc/sudoers"
