Ansible Spinal Stack
====================

This playbook aims to deploy a SpinalStack platform on a libvirt hypervisor.

Prerequisite
------------

The only prerequisite for ansible-spinalstack to work is to retrieve two eDeploy images. The install-server and openstack-full roles.

Currently, there is an issue with the qcow2 images so one should retrieve the raw image and convert it to a qcow2 image.

   qemu-img convert -f raw -o qcow2 myimage.img myimage.qcow2

Run it
------

One can find helper scripts in the contrib directory.

The `prepare.sh` will build qcow2 images on top of the base images. It will also create the `seed.iso` disk to inject information through cloud-init.

Simply run the following to be up and running :

    ansible-playbook site.yml

ToDo
----

* Templatize the libvirt xml description domain file
* Create a wrapper that would handler any architecture (ie. an n number of openstackfull images)
