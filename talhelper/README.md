# Démo #2

Découverte de [TalHelper](https://github.com/budimanjojo/talhelper)

---

**Installation de `talhelper`:**

```sh
curl https://i.jpillora.com/budimanjojo/talhelper! | sudo bash
```

**Générer les certificats/tokens:**

```sh
talhelper gensecret > talsecret.yaml
```

**Génération de la configuration:**

```sh
talhelper genconfig
```

**Obtenir la commande d'apply:**

```sh {"terminalRows":"11"}
talhelper gencommand apply --extra-flags --insecure
```

```sh
talosctl apply-config --talosconfig=./clusterconfig/talosconfig --nodes=192.168.1.101 --file=./clusterconfig/talos-cluster-cp-1.yaml --insecure;
talosctl apply-config --talosconfig=./clusterconfig/talosconfig --nodes=192.168.1.102 --file=./clusterconfig/talos-cluster-cp-2.yaml --insecure;
talosctl apply-config --talosconfig=./clusterconfig/talosconfig --nodes=192.168.1.103 --file=./clusterconfig/talos-cluster-cp-3.yaml --insecure;
talosctl apply-config --talosconfig=./clusterconfig/talosconfig --nodes=192.168.1.114 --file=./clusterconfig/talos-cluster-worker-1.yaml --insecure;
```

**Bootstrap etcd :**

```sh {"terminalRows":"6"}
talhelper gencommand bootstrap
```

```sh {"terminalRows":"2"}
talosctl bootstrap --talosconfig=./clusterconfig/talosconfig --nodes=192.168.1.101
```

**Récupérer le `kubeconfig`:**

```sh {"name":"Template - Récupération du kubeconfig","terminalRows":"3"}
talhelper gencommand kubeconfig --extra-flags --merge=false
```

```sh {"name":"Récupération du kubeconfig"}
talosctl kubeconfig --talosconfig=./clusterconfig/talosconfig --merge=false --nodes=192.168.1.101;
```