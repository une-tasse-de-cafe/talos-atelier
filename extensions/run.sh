#!/bin/bash

########################
# include the magic    #
########################
. ../common/demo-magic.sh
# hide the evidence
clear

pe "yq eval -o=json customization.yaml > customization.json"
pe "cat customization.json"

fpe 'curl -X POST https://factory.talos.dev/schematics
  -H "Content-Type: application/json"
  -d @customization.json'

fpe "talosctl --force --talosconfig=../talhelper/clusterconfig/talosconfig upgrade --image=factory.talos.dev/installer/ce4c980550dd2ab1b17bbf2b08801c7eb59418eafe8f279833297925d67c7515:v1.8.1"

pe "talosctl services --talosconfig ../talhelper/clusterconfig/talosconfig | grep qemu" 