Apache VCL Playbook
===================

This playbook will install Apache VCL 2.3 on a single CentOS 6 host.

There is a "blog post":http://www.cybera.ca/tech-radar/first-look-ansible that covers the basics of installing VCL using this playbook.

Using Vagrant
-------------

* Init a CentOS6 vagrant image

	vagrant_host$ mkdir some_new_vagrant_box; cd some_new_vagrant_box
	vagrant_host$ vagrant init centos6 #assuming you have a CentOS 6 box
    vagrant_host$ git clone ${thisrepo}
    vagrant_host$ vagrant up #box will build...
    vagrant_host$ vagrant ssh
    centos6$ cd /vagrant/ansible_playbooks/vcl
    centos6$ sudo ./bootstrap_ansible.sh
    centos6$ ssh root@localhost #do this once to accept the host key
    root@centos6$ exit
    centos6$ ansible-playbook all.yml # and wait

