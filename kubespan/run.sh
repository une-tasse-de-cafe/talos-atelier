#!/usr/bin/env bash

########################
# include the magic    #
########################
. ../common/demo-magic.sh
. ../common/prettytable.sh

# hide the evidence
clear

{
 printf 'NAME\tIP\tROLE\tZONE\n';
 printf '%s\t%s\t%s\t%s\n' "cp-1" "192.168.128.66" "ControlPlane" "OVH";
 printf '%s\t%s\t%s\t%s\n' "cp-2" "192.168.1.12" "ControlPlane" "Maison";
} | prettytable 4

pe "cat talconfig.yaml"

pe "talhelper gensecret > talsecret.yaml"

pe "talhelper genconfig"

pe "talhelper gencommand apply --extra-flags --insecure"

fpe 'talosctl apply-config --talosconfig=./clusterconfig/talosconfig --nodes=192.168.1.12 --file=./clusterconfig/kubespan-cluster-cp-zone-home.yaml --insecure & 
talosctl apply-config --talosconfig=./clusterconfig/talosconfig --nodes=192.168.128.66 --file=./clusterconfig/kubespan-cluster-cp-zone-cloud.yaml --insecure;'

pe "talhelper gencommand bootstrap"
fpe "talosctl bootstrap --talosconfig=./clusterconfig/talosconfig --nodes=192.168.1.12"


pe "talhelper gencommand kubeconfig --extra-flags --merge=false"
fpe "talosctl kubeconfig --talosconfig=./clusterconfig/talosconfig --merge=false --nodes=192.168.1.12;"

pe "kubectl --kubeconfig ./kubeconfig get pods -A"


pe "talosctl get affiliates --talosconfig=./clusterconfig/talosconfig --nodes=192.168.1.12"
pe "talosctl --talosconfig clusterconfig/talosconfig get rd --nodes=192.168.1.12| grep kubespan "

pe "talosctl --talosconfig clusterconfig/talosconfig get kubespanpeerstatuses.kubespan.talos.dev"
pe "talosctl --talosconfig clusterconfig/talosconfig get kubespanidentities.kubespan.talos.dev"

