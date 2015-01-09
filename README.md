Ansible Spinal Stack
====================

This playbook aims to deploy a SpinalStack platform on a libvirt hypervisor.

Prerequisite
------------

## RHEL

On a vanilla EL7 platform the following packages are necessary:

  * genisoimage
  * ansible
  * libvirt-python
  * qemu-kvm

*Note*: For qemu-kvm to be in the right path for ansible execution run `ln -s /usr/libexec/qemu-kvm /usr/bin/qemu-kvm`

## Fedora

On a Fedora 21 platform, you need the same packages and to remove firewalld::

    sudo service iptables save
    sudo systemctl disable firewalld
    sudo systemctl enable iptables
    sudo systemctl stop firewalld
    sudo systemctl start iptables

    yum remove firewalld

## Debian

The tool is know to work on Debian 7 too. In this case, you will need some
packages from wheezy-backports (qemu and libvirt-bin). You will also need to install
the python-paramiko package by yourself.

## NTP

Make sure the ntp daemon is running on the host machine as the guests will take time from it

## eDeploy

For ansible-spinalstack to work one needs to retrieve two eDeploy images. The install-server and openstack-full roles.

Currently, there is an issue with the qcow2 images so one should retrieve the raw image and convert it to a qcow2 image.

```
qemu-img convert -f raw -o qcow2 myimage.img myimage.qcow2
```

## SSH key

You need also a SSH key. We expect the public key to be in the standard `~/.ssh/id_rsa.pub` file.

Run it
------

The `prepare.sh` will build qcow2 images on top of the base images. It will also create the `seed.iso` disk to inject information through cloud-init.

The `clean.sh` will destroy and undefine libvirt domains and network. It will also clean the filesystem from previous seed and edeploy images.

Simply run the following to be up and running :

    $ ansible-playbook -i hosts -c paramiko site.yml

New virtual machines will be created at every run and your `~/.ssh/known_hosts` will quickly
be outdate. The `ansible.cfg` comes with the following line: `host_key_checking = False` to
disable SSH host checking.

We also strongly recommend the use of paramiko.

ToDo
----

* Templatize the libvirt xml description domain file
* Create a wrapper that would handler any architecture (ie. an n number of openstackfull images)
