Apache VCL Playbook
===================

This playbook will install Apache VCL 2.3 on a single CentOS 6 host.

There is a [blog post](http://www.cybera.ca/tech-radar/first-look-ansible) that describes a bit about how to install VCL with this playbook, though it is a bit older now. The best way to install using this playbook is to adapt the Vagrant process listed below to your environment.

RPM
---

Note that this playbook installs VCL via custom RPMs from a [custom RPM repository](http://packages.serverascode.com/mrepo). The spec file for the RPMs can be found [here](https://github.com/cybera/rpmspecs/blob/master/vcl.spec).

In a production environment you may want to either create your own RPMs based on that spec file or perform some sort of verification process.

Ansible
-------

Note that ansible is being installed from a [custom RPM repository](http://packages.serverascode.com/mrepo) because it seems like the ansible RPM in EPEL doesn't seem to handle templates well.

In a production environment you may want to install ansible from your own repository, or perhaps at this point the EPEL ansible RPM will be a later version that does not have templating issues.

Via Vagrant
-------------

```shell
vagrant_host$ mkdir some_new_vagrant_box; cd some_new_vagrant_box
vagrant_host$ vagrant init centos6 #assuming you have a CentOS 6 box
vagrant_host$ git clone ${thisrepo}
vagrant_host$ vagrant up #box will build...
vagrant_host$ vagrant ssh
centos6$ cd /vagrant/ansible_playbooks/vcl
centos6$ vi ./bootstrap_ansible.sh #take a look at what it's doing as it's going to be run as root
centos6$ sudo ./bootstrap_ansible.sh #must run as root, should really be a vagrant provisioning plugin but...
centos6$ cp vars/example-main.yml vars/main.yml
centos6$ vi vars/main.yml #edit the file
centos6$ ssh root@localhost #do this once to accept the host key
root@centos6$ exit
centos6$ export ANSIBLE_HOSTS=`pwd`/ansible_hosts #set the env variable for ansible 
centos6$ ansible -m ping 127.0.0.1 #test connecitivity to root@localhost
centos6$ ansible-playbook all.yml #and wait...
```

