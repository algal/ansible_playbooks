#!/bin/bash

if [[ $UID -ne 0 ]]; then
    echo "$0 must be run as root"
    exit 1
fi

if ! which ansible > /dev/null ; then
	if [ ! -e /vagrant/ansible ]; then
		pushd /vagrant
			apt-get install git -y
			git clone git://github.com/ansible/ansible.git || exit 1
		popd
	fi
	pushd /vagrant/ansible
		apt-get install python-yaml python-paramiko python-jinja2 make -y
		make install
	popd
fi

if [ ! -e ./ansible_hosts ]; then

cat << EOANSIBLE_HOSTS > ./ansible_hosts
[openstack]
127.0.0.1
EOANSIBLE_HOSTS

fi

if ! grep ANSIBLE_HOSTS /home/vagrant/.bashrc; then
	echo "export ANSIBLE_HOSTS=/home/vagrant/ansible_hosts" >> /home/vagrant/.bashrc
fi

# Not all that helpful unless actually running as root, ie. not sudo
export ANSIBLE_HOSTS=`pwd`/ansible_hosts

# Add a new ssh for vagrant and stuff into root's authorized_keys file
# so that ansible has something to ssh into
if [ ! -e /root/.ssh/authorized_keys ]; then
	mkdir /root/.ssh
	chmod 700 /root/.ssh
	/usr/bin/ssh-keygen -q -t dsa -C '' -N '' -f /home/vagrant/.ssh/id_dsa
	chown vagrant:vagrant /home/vagrant/.ssh/id_dsa*
	cat /home/vagrant/.ssh/id_dsa.pub >> /root/.ssh/authorized_keys
	chmod 600 /root/.ssh/authorized_keys
fi
