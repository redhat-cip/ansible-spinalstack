#!/bin/bash
#
# Copyright (C) 2014 eNovance SAS <licensing@enovance.com>
#
# Author: Yanis Guenane <yanis.guenane@enovance.com>
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.

openstack_nodes="openstack1 openstack2 openstack3"
image_path="/var/lib/libvirt/images/"

#
# Create a new image using the official edeploy roles
# as base.
#
qemu-img create -f qcow2 -b $image_path/installserver-original.img.qcow2 $image_path/installserver.qcow2 40G
genisoimage -output $image_path/seed-installserver.iso -volid cidata -joliet -rock seed/user-data seed/installserver/meta-data

for node in $openstack_nodes
do
  qemu-img create -f qcow2 -b $image_path/openstackfull-original.img.qcow2 $image_path/${node}.qcow2 40G
  genisoimage -output $image_path/seed-${node}.iso -volid cidata -joliet -rock seed/user-data seed/${node}/meta-data
  for i in $(seq 1 4)
  do
    qemu-img create -f qcow2 $image_path/${node}-ceph4${i}.img 10G
  done
done
