#!/bin/bash

DEMO_PROMPT="${PS1}"

########################
# include the magic    #
########################
. ../common/demo-magic.sh

# hide the evidence
clear

pei "talhelper gensecret > talsecret.yaml"
pei "ls -l talsecret.yaml"

pe "talhelper genconfig"