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

nodes="installserver openstack1 openstack2 openstack3"
networks="spinalstack"
image_path="/var/lib/libvirt/images"

#
# Shutdown and remove domain from a virsh point of view
# Remove the qcow file this image was relying on
#
for node in $nodes
do
  virsh destroy $node
  virsh undefine $node
  rm -f $image_path/${node}.qcow2
done

#
# Remove and network
#
for network in $networks
do
  virsh net-destroy $network
done
