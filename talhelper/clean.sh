#!/bin/bash

########################
# include the magic    #
########################
. ../common/demo-magic.sh

# hide the evidence
clear

pe "# Reset the cluster \n"
pe "talhelper gencommand reset"

fpe "talosctl reset --talosconfig=./clusterconfig/talosconfig --nodes=192.168.1.101 --graceful=false --reboot &
talosctl reset --talosconfig=./clusterconfig/talosconfig --nodes=192.168.1.102 --graceful=false --reboot &
talosctl reset --talosconfig=./clusterconfig/talosconfig --nodes=192.168.1.103 --graceful=false --reboot &
talosctl reset --talosconfig=./clusterconfig/talosconfig --nodes=192.168.1.114 --graceful=false --reboot;"

