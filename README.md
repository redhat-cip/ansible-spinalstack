Ansible Spinal Stack
====================

This playbook aims to deploy a SpinalStack platform on a libvirt hypervisor.

Prerequisite
------------

### Packages

On a vanilla EL7 platform the following packages are necessary :

  * genisoimage
  * ansible
  * libvirt-python
  * qemu-kvm

*Note*: For qemu-kvm to be in the right path for ansible execution run `ln -s /usr/libexec/qemu-kvm /usr/bin/qemu-kvm`

### NTP

Make sure the ntp daemon is running on the host machine as the guests will take time from it

### eDeploy

For ansible-spinalstack to work one needs to retrieve two eDeploy images. The install-server and openstack-full roles.

Currently, there is an issue with the qcow2 images so one should retrieve the raw image and convert it to a qcow2 image.

```
qemu-img convert -f raw -o qcow2 myimage.img myimage.qcow2
```


Run it
------

One can find two helper scripts in the `contrib/` directory.

The `prepare.sh` will build qcow2 images on top of the base images. It will also create the `seed.iso` disk to inject information through cloud-init.

The `clean.sh` will destroy and undefine libvirt domains and network. It will also clean the filesystem from previous seed and edeploy images.

Simply run the following to be up and running :

    $ ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts site.yml

New virtual machines will be created and `~/.ssh/known_hosts` will be outdate.
`ANSIBLE_HOST_KEY_CHECKING=False` disable ssh known host check.

ToDo
----

* Templatize the libvirt xml description domain file
* Create a wrapper that would handler any architecture (ie. an n number of openstackfull images)
