#!/usr/bin/env bash

if [ ! -f /etc/yum.repos.d/mongodb.repo ];
then
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
else
	echo "Repositorio de MongoDB ya agregado anteriormente";
fi

ret=false
getent passwd nginx >/dev/null 2>&1 && ret=true

if $ret; then
	echo "El usuario nginx existe, saltarse la creación"
else
	useradd -s /bin/false nginx
fi

# Uncomment if want Denyhosts
# sudo rpm -Uvh http://mirror.metrocast.net/fedora/epel/6/i386/epel-release-6-8.noarch.rpm
# sudo yum install denyhosts
