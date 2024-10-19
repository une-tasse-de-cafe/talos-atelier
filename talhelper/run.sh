#!/bin/bash

########################
# include the magic    #
########################
. ../common/demo-magic.sh

# hide the evidence
clear

pei "talhelper gensecret > talsecret.yaml"
pei "ls -l talsecret.yaml"
pe "talhelper genconfig"
pe "talhelper gencommand apply"

pei "talhelper gencommand apply --extra-flags --insecure"
pe "talosctl apply-config --talosconfig=./clusterconfig/talosconfig --nodes=192.168.1.101 --file=./clusterconfig/talos-cluster-cp-1.yaml --insecure;
talosctl apply-config --talosconfig=./clusterconfig/talosconfig --nodes=192.168.1.102 --file=./clusterconfig/talos-cluster-cp-2.yaml --insecure;
talosctl apply-config --talosconfig=./clusterconfig/talosconfig --nodes=192.168.1.103 --file=./clusterconfig/talos-cluster-cp-3.yaml --insecure;
talosctl apply-config --talosconfig=./clusterconfig/talosconfig --nodes=192.168.1.114 --file=./clusterconfig/talos-cluster-worker-1.yaml --insecure;"
pe "talhelper gencommand bootstrap"
pe "talosctl bootstrap --talosconfig=./clusterconfig/talosconfig --nodes=192.168.1.101"

pei "talhelper gencommand kubeconfig --extra-flags --merge=false"
pe "talosctl kubeconfig --talosconfig=./clusterconfig/talosconfig --merge=false --nodes=192.168.1.101;"

pe "kubectl --kubeconfig ./kubeconfig get pods -A"

