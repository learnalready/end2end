#!/usr/bin/env bash

sudo -H -u ubuntu echo "LS_COLORS=\$LS_COLORS:'di=0;35:' ; export LS_COLORS" >> /home/ubuntu/.bashrc
apt-get update

echo "Install Docker..."
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list
apt-get update
sudo apt-get -y install linux-image-extra-$(uname -r) linux-image-extra-virtual
sudo apt-get -y install docker-engine
sudo service docker start
sleep 3
sudo docker pull microsoft/dotnet:latest
