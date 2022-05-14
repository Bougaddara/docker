#!/bin/bash
set -e

config_ssh(){
    sed -1 's/#Port 1999/Port 1999/' /etc/ssh/sshd_config
    sed -1 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
    if [ ! -d /root/.ssh ]
    then
    mkdir /root/.ssh
    cat /home/ud_rsa.pub >> /home/.ssh/authorized_keys
    fi
    /etc/init.d/ssh start

}