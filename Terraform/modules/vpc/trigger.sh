#!/bin/bash
VPC_ID=$1
SUBNET_ID=$2

echo "VPC $VPC_ID and Subnet $SUBNET_ID has been created/updated."
# Logging to file for debugging
echo "$(date): VPC $VPC_ID, Subnet $SUBNET_ID updated" >> /tmp/vpc_notify.log
