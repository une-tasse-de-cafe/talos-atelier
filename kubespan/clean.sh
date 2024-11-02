#!/bin/bash

########################
# include the magic    #
########################
. ../common/demo-magic.sh

# hide the evidence
clear

pe "talhelper gencommand reset --extra-flags --graceful=false --extra-flags --reboot"

fpe "talosctl reset --talosconfig=./clusterconfig/talosconfig --nodes=192.168.1.12 --graceful=false --reboot &
talosctl reset --talosconfig=./clusterconfig/talosconfig --nodes=192.168.128.66 --graceful=false --reboot;"

rm kubeconfig

