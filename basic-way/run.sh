#!/bin/bash

########################
# include the magic    #
########################
. ../common/demo-magic.sh
. ../common/prettytable.sh

# hide the evidence
clear

{
 printf 'NAME\IP\ROLE\n';
 printf '%s\t%s\t%s\n' "cp-1" "192.168.1.101" "ControlPlane";
 printf '%s\t%s\t%s\n' "cp-2" "192.168.1.102" "ControlPlane";
 printf '%s\t%s\t%s\n' "cp-3" "192.168.1.103" "ControlPlane";
 printf '%s\t%s\t%s\n' "worker-1" "192.168.1.104" "Worker";
} | prettytable 3

pei "talosctl gen secrets"
pei "ls -l secrets.yaml"

pe "vim secrets.yaml"

pei "talosctl gen config demo https://192.168.1.101:6443"
sleep 1
pei "ls -lh"

pe "vim controlplane.yaml"

pe "talosctl apply-config -f ./controlplane.yaml -e 192.168.1.101 -n 192.168.1.101 --insecure"
pei "talosctl apply-config -f ./controlplane.yaml -e 192.168.1.102 -n 192.168.1.102,192.168.1.103 --insecure"

repl

pei "talosctl bootstrap "

sleep 2

pe "talosctl etcd members -n 192.168.1.101 -e 192.168.1.101 --talosconfig ./talosconfig"
repl

pe "talosctl kubeconfig ---merge=false -n 192.168.1.101 -e 192.168.1.101 --talosconfig ./talosconfig"
pei "kubectl --kubeconfig ./kubeconfig get pods -A"
pe "kubectl --kubeconfig ./kubeconfig get nodes"

pei "talosctl apply-config -f ./worker.yaml -e 192.168.1.104 -n 192.168.1.104 --insecure"

echo "------------"
