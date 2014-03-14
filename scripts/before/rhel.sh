#!/usr/bin/env bash

if [ $(uname -m) == 'x86_64' ]; then
	echo '[mongodb]
name=MongoDB Repository
baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64/
gpgcheck=0
enabled=1' > /etc/yum.repos.d/mongodb.repo
	exit 0;
fi

if [ $(uname -m) == 'i686' ]; then
	echo '[mongodb]
name=MongoDB Repository
baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/i686/
gpgcheck=0
enabled=1' > /etc/yum.repos.d/mongodb.repo
	exit 0;
fi

useradd -s /bin/false nginx

sudo rpm -Uvh http://mirror.metrocast.net/fedora/epel/6/i386/epel-release-6-8.noarch.rpm
sudo yum install denyhosts
