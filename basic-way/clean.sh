#!/bin/bash

########################
# include the magic    #
########################
. ../common/demo-magic.sh

# hide the evidence
clear

pe "talosctl reset --talosconfig ./talosconfig -e 192.168.1.101 -n 192.168.1.104,192.168.1.103,192.168.1.102,192.168.1.101 --graceful=false"

rm -f talosconfig kubeconfig controlplane.yaml worker.yaml secrets.yaml