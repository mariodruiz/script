#!/bin/bash

user=$(whoami)
if [ "$user" != "root" ]; then
   echo "You must be root for execute this script"
   exit 1;
fi

MAC=90:FB:A6:86:2F:10
interface=eth2

/sbin/modprobe dummy
/sbin/ip link set name $interface dev dummy0
/sbin/ifconfig $interface hw ether $MAC
ifconfig $interface up
