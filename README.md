# Atelier Talos

## Introduction

Ce dépôt contient les différentes démonstrations à réaliser lors de l'atelier Talos / talk *Un cluster de production en un éclair avec Talos ⚡️☸️*. Dans l'ordre, voici les sections prévues :
- `basic-way` - Déploiement d'un cluster Kubernetes avec Talos en suivant la méthode classique (Génération des secrets, génération des fichiers de configuration, installation des Control Plane, Bootstrap et Worker Nodes)
- `talhelper` - Dissociation des secrets et des fichiers de configuration avec TalHelper. Les commandes sont simplifiées et les fichiers de configuration sont générés automatiquement en fonction de la configuration des nœuds.
- `extensions` - Installation de l'extension `qemu-guest-agent` sur les nœuds d'un cluster déjà en place. Cette extension permet de récupérer l'adresse IP (mais pas que) des nœuds directement depuis l'hyperviseur.
- `omni-talos-cluster-template` - Déploiement d'un cluster Talos à partir de Omni.

## Prérequis

- 4 machines virtuelles (ou physiques) avec une connexion internet (machines Talos).
- Un abonnement à Omni ou sa version open-source (et selfhosted).
- Les scripts [`demo-magic.sh`](https://github.com/paxtonhare/demo-magic) et [`prettytable`](https://github.com/jakobwesthoff/prettytable.sh) pour les démonstrations.
- `talosctl`, `talhelper`, `omnictl` et `kubectl` installés sur votre machine.

## Licence

Ce dépôt est sous licence MIT. Voir le fichier `LICENSE` pour plus d'informations.