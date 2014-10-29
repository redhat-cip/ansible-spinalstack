Ansible Spinal Stack
====================

Prerequisite
------------

1. Retrieve the images

Retrieve install-server and openstackfull

2. Creating a root user and inserting your keys

mount -o loop,offset=31744  /var/lib/libvirt/images/install-server.img /mnt

passwd + copy authorized_keys

3. Resize actual file system

truncate -r installserver.img biginstallserver.img
truncate -s +20G biginstallserver.img
virt-resize --resize sda1=+20G installserver.img biginstallserver.img
