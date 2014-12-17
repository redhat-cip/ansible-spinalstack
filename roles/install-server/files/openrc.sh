#!/bin/bash

export OS_AUTH_URL=http://vip.example.com:5000/v2.0
#export OS_TENANT_ID=6cb9d2b772454e10a9257bc881898dd8
export OS_TENANT_NAME="admin"
export OS_USERNAME="admin"
export OS_PASSWORD=password

export OS_REGION_NAME="zone42"
# Don't leave a blank variable, unset it if it was empty
if [ -z "$OS_REGION_NAME" ]; then unset OS_REGION_NAME; fi
