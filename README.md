# TypeSeq HPV
***NCI CGR laboratory HPV typing analysis workflows and R package***

TypeSeqer Plugin Described by CWL
================

-   Install docker
-   Make Docker storage more robust on torrent server
-   download and unpack latest Rabix release
-   download and add hpv-typing plugin via torrent server gui

Detailed Installation Instructions
----------------------------------

### Install docker

    sudo apt-get install docker.io
    sudo usermod -aG docker [user name] 
    sudo docker login (with any docker user id)
    sudo usermod -aG docker ionian
    sudo su ionian
    docker login (with any docker user id)
    su ionadmin

### Make Docker storage more robust on torrent server

    sudo service docker stop
    cd /var/lib
    sudo rsync -a docker /results/plugins/scratch/
    sudo rm -rf docker
    sudo ln -s docker /results/plugins/scratch/docker
    sudo vi /etc/default/docker

Modify this line

    #DOCKER_OPTS="--dns 8.8.8.8 --dns 8.8.4.4"

Changing it to this

    DOCKER_OPTS="--dns 8.8.8.8 --dns 8.8.4.4 -g /results/plugins/scratch/docker"

Restart Docker

    sudo service docker start 
    
## Download and Unpack Rabix

This plugin has only been tested with a specific pre-realease version of rabix bunny.

https://github.com/rabix/bunny/releases/tag/v1.0.0-rc2

A backup copy of this release is stored here

https://s3.amazonaws.com/typeseqer/rabix-1.0.0-rc2.tar.gz
    

## Download and add hpv-typing plugin via torrent server gui

https://github.com/davidroberson/TypeSeqer-private/releases/tag/v1.33001.180
