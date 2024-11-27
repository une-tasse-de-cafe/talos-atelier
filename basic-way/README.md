# Démo #1
---
Installation d'un Talos "The Basic Way" sur un cluster de 4 noeuds : 

| Noeud | IP | Rôle |
| --- | --- | --- |
| cp-1 | 192.168.1.101 | Control Plane |
| cp-2 | 192.168.1.102 | Control Plane |
| cp-3 | 192.168.1.103 | Control Plane |
| w-1 | 192.168.1.114 | Worker | 

**Génération des secrets**:

```sh {"background":"true","name":"gen-secret"}
talosctl gen secrets
ls -l secrets.yaml
```

**Génération de la configuration**:

```sh
talosctl gen config talk-talos https://192.168.1.101:6443
```

**Appliquer la configuration sur les noeuds**:

```sh
talosctl apply-config -f ./controlplane.yaml -e 192.168.1.101 -n 192.168.1.101 --insecure
talosctl apply-config -f ./controlplane.yaml -e 192.168.1.102 -n 192.168.1.102 --insecure
talosctl apply-config -f ./controlplane.yaml -e 192.168.1.103 -n 192.168.1.103 --insecure
TALOSCONFIG=talosconfig talosctl config endpoint 192.168.1.101
```

---











**Afficher les logs du noeud `192.168.1.101`:**

```sh {"terminalRows":"27"}
TALOSCONFIG=talosconfig talosctl dmesg -e 192.168.1.101 -n 192.168.1.101 --talosconfig ./talosconfig
```

Lancer l'opération de **Bootstrap** sur le noeud `192.168.1.101`:

```sh
TALOSCONFIG=talosconfig talosctl bootstrap -n 192.168.1.101 -e 192.168.1.101 --talosconfig ./talosconfig
```

**Récupérer le fichier `kubeconfig`**:

```sh
TALOSCONFIG=talosconfig talosctl kubeconfig -n 192.168.1.101 --merge=false
```

```sh {"terminalRows":"30"}
KUBECONFIG=kubeconfig k9s
```

**Appliquer le dernier worker**:

```sh
TALOSCONFIG=talosconfig talosctl apply-config -f worker.yaml -n 192.168.1.114 --insecure
```

---

**Reset les machines et le cluster**:

```sh
TALOSCONFIG=talosconfig talosctl reset -n 192.168.1.114,192.168.1.103,192.168.1.102,192.168.1.101 --graceful=false --reboot 
```

```sh
rm talosconfig kubeconfig controlplane.yaml worker.yaml secrets.yaml
```