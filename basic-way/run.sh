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

pei "talosctl gen secrets"
pei "ls -l secrets.yaml"

#pe "vim secrets.yaml"

echo "Create the configuration with "demo" as cluster name and the IP of the first controlplane node"
pei "talosctl gen config demo https://192.168.1.101:6443"
sleep 1

p "ls -lh"

ls -l controlplane.yaml secrets.yaml worker.yaml talosconfig

#pe "vim controlplane.yaml"
pe "talosctl apply-config -f ./controlplane.yaml -e 192.168.1.101 -n 192.168.1.101 --insecure"
pe "talosctl apply-config -f ./controlplane.yaml -e 192.168.1.102 -n 192.168.1.102 --insecure"
pei "talosctl apply-config -f ./controlplane.yaml -e 192.168.1.103 -n 192.168.1.103 --insecure"

echo "------------"

pe "export TALOSCONFIG=./talosconfig"
export TALOSCONFIG=./talosconfig
pei "talosctl config endpoint 192.168.1.101"
pei "talosctl config node 192.168.1.101 192.168.1.102 192.168.1.103"

pe "talosctl dmesg -n 192.168.1.101"

pe "talosctl bootstrap -n 192.168.1.101"
sleep 1

pe "talosctl etcd members -n 192.168.1.101"

pe "talosctl kubeconfig --merge=false -n 192.168.1.101"
pe "kubectl --kubeconfig ./kubeconfig get pods -A"
pe "kubectl --kubeconfig ./kubeconfig get nodes"

pei "talosctl apply-config -f ./worker.yaml -e 192.168.1.114 -n 192.168.1.114 --insecure"

pei "kubectl --kubeconfig ./kubeconfig get nodes -w"

echo "------------"
