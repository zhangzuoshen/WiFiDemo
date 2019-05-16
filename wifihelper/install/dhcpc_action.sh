#!/bin/sh

# wpa_cli -a/sbin/dhcpc_action.sh -i wlan0

IFNAME=$1
CMD=$2

if [ "$CMD" = "CONNECTED" ]; then
   echo Start DHCP Client for $IFNAME # > /dev/console
   udhcpc -q -i $IFNAME -n
fi
if [ "$CMD" = "DISCONNECTED" ]; then
   echo Finish DHCP Client for $IFNAME # > /dev/console
   ifconfig $IFNAME 0.0.0.0
fi
