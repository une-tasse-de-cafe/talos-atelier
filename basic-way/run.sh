
#!/bin/bash

DEMO_PROMPT="${PS1}"

########################
# include the magic    #
########################
. ../common/demo-magic.sh

# hide the evidence
clear

pei "talosctl gen secrets"
pei "ls -l secrets.yaml"

pe "vim secrets.yaml"

pei "talosctl gen config demo https://192.168.1.101:6443"
sleep 1
pei "ls -lh"

pe "vim controlplane.yaml"
echo "------------"
