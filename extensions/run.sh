#!/bin/bash

########################
# include the magic    #
########################
. ../common/demo-magic.sh
. ../common/prettytable.sh

# hide the evidence
clear

{
 printf 'NAME\tIP\tROLE\n';
 printf '%s\t%s\t%s\n' "cp-1" "192.168.1.101" "ControlPlane";
 printf '%s\t%s\t%s\n' "cp-2" "192.168.1.102" "ControlPlane";
 printf '%s\t%s\t%s\n' "cp-3" "192.168.1.103" "ControlPlane";
 printf '%s\t%s\t%s\n' "worker-1" "192.168.1.114" "Worker";
} | prettytable 3

pe "yq eval -o=json customization.yaml > customization.json"
pe "cat customization.json"

fpe 'curl -X POST https://factory.talos.dev/schematics
  -H "Content-Type: application/json"
  -d @customization.json'

fpe "talosctl --force --talosconfig=../talhelper/clusterconfig/talosconfig upgrade --image=factory.talos.dev/installer/ce4c980550dd2ab1b17bbf2b08801c7eb59418eafe8f279833297925d67c7515:v1.8.1"

pe "talosctl services --talosconfig ../talhelper/clusterconfig/talosconfig | grep qemu" 

echo "------------"